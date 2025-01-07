module 0x69328fb5450bf017f21ce2c925e6797ad934bc3d9c40854fdbb591aaa638791f::ticket {
    struct MinterData has store, key {
        id: 0x2::object::UID,
        owner: address,
        collection_name: 0x1::string::String,
        collection_description: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        next_token_id: u64,
    }

    struct InfoNFT has store {
        tier: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct DesuiTicket has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
        created_at: u64,
    }

    struct MintNFTEvent has copy, drop {
        id: 0x2::object::ID,
        buyer: address,
        id_nft: 0x2::object::ID,
        name_nft: 0x1::string::String,
    }

    struct TICKET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: DesuiTicket, arg1: &mut 0x2::tx_context::TxContext) {
        let DesuiTicket {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            project_url : _,
            created_at  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        let v4 = 0x2::package::claim<TICKET>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DesuiTicket>(&v4, v0, v2, arg1);
        0x2::display::update_version<DesuiTicket>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DesuiTicket>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = MinterData{
            id                     : 0x2::object::new(arg1),
            owner                  : 0x2::tx_context::sender(arg1),
            collection_name        : 0x1::string::utf8(b"Ticket Desui"),
            collection_description : 0x1::string::utf8(b"This ticket serves as your official invitation to claim your exclusive Freemint NFT Tier 2 from the Desui."),
            image_url              : 0x1::string::utf8(b"http://ipfs.io/ipfs/QmSfa6prgRrRa3w43bSWfUwkWUMQiuMLZ912GePafE6Q5u"),
            project_url            : 0x1::string::utf8(b"https://desui.io/"),
            next_token_id          : 1,
        };
        0x2::transfer::public_transfer<MinterData>(v6, @0x14369c0c3eba649ae0d0f52546be19e5a191e0adf2d7c955507c1fc131c25738);
    }

    public entry fun mint(arg0: &mut MinterData, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.collection_name;
        0x1::string::append(&mut v0, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v0, num_str(arg0.next_token_id));
        let v1 = DesuiTicket{
            id          : 0x2::object::new(arg3),
            name        : v0,
            description : arg0.collection_description,
            image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(arg0.image_url)),
            project_url : 0x2::url::new_unsafe(0x1::string::to_ascii(arg0.project_url)),
            created_at  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::transfer::public_transfer<DesuiTicket>(v1, arg2);
        arg0.next_token_id = arg0.next_token_id + 1;
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

