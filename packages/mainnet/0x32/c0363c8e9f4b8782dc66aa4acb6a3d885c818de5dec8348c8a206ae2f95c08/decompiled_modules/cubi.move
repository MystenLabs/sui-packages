module 0x32c0363c8e9f4b8782dc66aa4acb6a3d885c818de5dec8348c8a206ae2f95c08::cubi {
    struct Cubi has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct EventMint has copy, drop {
        receiver: address,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct EventClaimWithSignature has copy, drop {
        receiver: address,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PublicKey has key {
        id: 0x2::object::UID,
        pk: vector<u8>,
    }

    struct CubiRegistry has key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<address, bool>,
    }

    struct CUBI has drop {
        dummy_field: bool,
    }

    public entry fun claimWithSignature(arg0: &mut CubiRegistry, arg1: &PublicKey, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&arg0.registry, arg5), 0);
        let v0 = 0x2::address::to_string(arg5);
        0x1::string::append(&mut v0, arg2);
        0x1::string::append(&mut v0, arg3);
        let v1 = 0x2::hash::blake2b256(0x1::string::bytes(&v0));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg1.pk, &v1) == true, 0);
        let v2 = Cubi{
            id      : 0x2::object::new(arg6),
            name    : arg2,
            img_url : arg3,
        };
        0x2::transfer::transfer<Cubi>(v2, arg5);
        0x2::table::add<address, bool>(&mut arg0.registry, arg5, true);
        let v3 = EventClaimWithSignature{
            receiver : arg5,
            name     : arg2,
            img_url  : arg3,
        };
        0x2::event::emit<EventClaimWithSignature>(v3);
    }

    public entry fun getPublicKey(arg0: &PublicKey) : vector<u8> {
        arg0.pk
    }

    fun init(arg0: CUBI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.cubicgames.xyz/games"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A true Cubi of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.cubicgames.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cubic Creator"));
        let v4 = 0x2::package::claim<CUBI>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Cubi>(&v4, v0, v2, arg1);
        0x2::display::update_version<Cubi>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Cubi>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = CubiRegistry{
            id       : 0x2::object::new(arg1),
            registry : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<CubiRegistry>(v7);
        let v8 = PublicKey{
            id : 0x2::object::new(arg1),
            pk : b"0x",
        };
        0x2::transfer::share_object<PublicKey>(v8);
    }

    public entry fun mint(arg0: &AdminCap, arg1: &mut CubiRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&arg1.registry, arg4), 0);
        let v0 = Cubi{
            id      : 0x2::object::new(arg5),
            name    : arg2,
            img_url : arg3,
        };
        0x2::transfer::transfer<Cubi>(v0, arg4);
        0x2::table::add<address, bool>(&mut arg1.registry, arg4, true);
        let v1 = EventMint{
            receiver : arg4,
            name     : arg2,
            img_url  : arg3,
        };
        0x2::event::emit<EventMint>(v1);
    }

    public entry fun setPublicKey(arg0: &AdminCap, arg1: &mut PublicKey, arg2: vector<u8>) {
        arg1.pk = arg2;
    }

    // decompiled from Move bytecode v6
}

