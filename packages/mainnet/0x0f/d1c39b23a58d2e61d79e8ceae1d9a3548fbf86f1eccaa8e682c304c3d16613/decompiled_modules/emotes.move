module 0xfd1c39b23a58d2e61d79e8ceae1d9a3548fbf86f1eccaa8e682c304c3d16613::emotes {
    struct Emote has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        igId: 0x1::string::String,
        rarity: 0x1::string::String,
        reaction: 0x1::string::String,
        image_url: 0x2::url::Url,
        url: 0x2::url::Url,
    }

    struct EMOTES has drop {
        dummy_field: bool,
    }

    struct MintEmoteEvent has copy, drop {
        object_id: 0x2::object::ID,
        name: 0x1::string::String,
        igId: 0x1::string::String,
        rarity: 0x1::string::String,
        reaction: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct AdminKey has store, key {
        id: 0x2::object::UID,
    }

    public fun url(arg0: &Emote) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: Emote) {
        let Emote {
            id        : v0,
            name      : _,
            igId      : _,
            rarity    : _,
            reaction  : _,
            image_url : _,
            url       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun create_admin_key(arg0: &AdminKey, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminKey{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminKey>(v0, arg1);
    }

    public fun igId(arg0: &Emote) : &0x1::string::String {
        &arg0.igId
    }

    public fun image_url(arg0: &Emote) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: EMOTES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"reaction"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{reaction}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aethergames.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Aether Games"));
        let v4 = 0x2::package::claim<EMOTES>(arg0, arg1);
        let v5 = AdminKey{id: 0x2::object::new(arg1)};
        let v6 = 0x2::display::new_with_fields<Emote>(&v4, v0, v2, arg1);
        0x2::display::update_version<Emote>(&mut v6);
        let (v7, v8) = 0x2::transfer_policy::new<Emote>(&v4, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Emote>>(v7);
        let v9 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<AdminKey>(v5, v9);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v9);
        0x2::transfer::public_transfer<0x2::display::Display<Emote>>(v6, v9);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Emote>>(v8, v9);
    }

    public fun mint(arg0: &AdminKey, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : Emote {
        let v0 = Emote{
            id        : 0x2::object::new(arg7),
            name      : arg1,
            igId      : arg2,
            rarity    : arg3,
            reaction  : arg4,
            image_url : 0x2::url::new_unsafe_from_bytes(arg5),
            url       : 0x2::url::new_unsafe_from_bytes(arg6),
        };
        let v1 = MintEmoteEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            name      : v0.name,
            igId      : v0.igId,
            rarity    : v0.rarity,
            reaction  : v0.reaction,
            image_url : v0.image_url,
        };
        0x2::event::emit<MintEmoteEvent>(v1);
        v0
    }

    public fun name(arg0: &Emote) : &0x1::string::String {
        &arg0.name
    }

    public fun rarity(arg0: &Emote) : &0x1::string::String {
        &arg0.rarity
    }

    public fun reaction(arg0: &Emote) : &0x1::string::String {
        &arg0.reaction
    }

    public entry fun set_igId(arg0: &AdminKey, arg1: &mut Emote, arg2: 0x1::string::String) {
        arg1.igId = arg2;
    }

    public entry fun set_image_url(arg0: &AdminKey, arg1: &mut Emote, arg2: vector<u8>) {
        arg1.image_url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    public entry fun set_name(arg0: &AdminKey, arg1: &mut Emote, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public entry fun set_rarity(arg0: &AdminKey, arg1: &mut Emote, arg2: 0x1::string::String) {
        arg1.rarity = arg2;
    }

    public entry fun set_reaction(arg0: &AdminKey, arg1: &mut Emote, arg2: 0x1::string::String) {
        arg1.reaction = arg2;
    }

    public entry fun set_url(arg0: &AdminKey, arg1: &mut Emote, arg2: vector<u8>) {
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    // decompiled from Move bytecode v6
}

