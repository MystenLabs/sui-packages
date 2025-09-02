module 0x136d3f735b8d7c630af8e2d3155942f6247a51203f1c7ba9f8dabdd1f7116fb4::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    struct Event has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        slug: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        start_ms: u64,
        end_ms: u64,
        cap: u64,
        minted: u64,
        admin: address,
    }

    struct PassNFT has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        event_name: 0x1::string::String,
        event_slug: 0x1::string::String,
        image_url: 0x1::string::String,
        minted_at: u64,
        holder: address,
    }

    struct EventCreated has copy, drop {
        event_id: 0x2::object::ID,
        slug: 0x1::string::String,
        admin: address,
    }

    struct PassMinted has copy, drop {
        pass_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        recipient: address,
    }

    struct EventUpdated has copy, drop {
        event_id: 0x2::object::ID,
        admin: address,
    }

    struct EventDeleted has copy, drop {
        event_id: 0x2::object::ID,
        admin: address,
    }

    public entry fun create_event(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = Event{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(arg0),
            slug        : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            start_ms    : arg4,
            end_ms      : arg5,
            cap         : arg6,
            minted      : 0,
            admin       : v0,
        };
        let v2 = EventCreated{
            event_id : 0x2::object::id<Event>(&v1),
            slug     : 0x1::string::utf8(arg1),
            admin    : v0,
        };
        0x2::event::emit<EventCreated>(v2);
        0x2::transfer::public_share_object<Event>(v1);
    }

    public fun get_event_info(arg0: &Event) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64) {
        (arg0.name, arg0.slug, arg0.description, arg0.start_ms, arg0.end_ms, arg0.cap, arg0.minted)
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CORE>(arg0, arg1);
        let v1 = 0x2::display::new<PassNFT>(&v0, arg1);
        0x2::display::add<PassNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{event_name} - SuiQuest JP Pass"));
        0x2::display::add<PassNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Commemorative NFT Pass for attending {event_name} at SuiQuest JP"));
        0x2::display::add<PassNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<PassNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suiquest.jp"));
        0x2::display::add<PassNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"SuiQuest JP"));
        0x2::display::update_version<PassNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PassNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_pass(arg0: &mut Event, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 >= arg0.start_ms, 0);
        assert!(v0 <= arg0.end_ms, 1);
        assert!(arg0.minted < arg0.cap, 2);
        let v2 = PassNFT{
            id         : 0x2::object::new(arg2),
            event_id   : 0x2::object::id<Event>(arg0),
            event_name : arg0.name,
            event_slug : arg0.slug,
            image_url  : arg0.image_url,
            minted_at  : v0,
            holder     : v1,
        };
        arg0.minted = arg0.minted + 1;
        let v3 = PassMinted{
            pass_id   : 0x2::object::id<PassNFT>(&v2),
            event_id  : 0x2::object::id<Event>(arg0),
            recipient : v1,
        };
        0x2::event::emit<PassMinted>(v3);
        0x2::transfer::public_transfer<PassNFT>(v2, v1);
    }

    public entry fun update_event_details(arg0: &mut Event, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 3);
        arg0.name = 0x1::string::utf8(arg1);
        arg0.description = 0x1::string::utf8(arg2);
        arg0.image_url = 0x1::string::utf8(arg3);
        let v0 = EventUpdated{
            event_id : 0x2::object::id<Event>(arg0),
            admin    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EventUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

