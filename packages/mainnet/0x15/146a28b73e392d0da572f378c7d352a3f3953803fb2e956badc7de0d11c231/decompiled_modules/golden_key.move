module 0x15146a28b73e392d0da572f378c7d352a3f3953803fb2e956badc7de0d11c231::golden_key {
    struct GOLDEN_KEY has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MinterCap has key {
        id: 0x2::object::UID,
    }

    struct GoldenKey has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: vector<0x1::string::String>,
    }

    fun init(arg0: GOLDEN_KEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GOLDEN_KEY>(arg0, arg1);
        let v1 = 0x2::display::new<GoldenKey>(&v0, arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::display::add<GoldenKey>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"GoGO Key #{number} - "));
        0x2::display::add<GoldenKey>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"The GoGO Key allows holders to mint a"));
        0x2::display::add<GoldenKey>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<GoldenKey>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://images.unsplash.com/photo-1458571037713-913d8b481dc6?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=1080&ixid=eyJhcHBfaWQiOjF9&ixlib=rb-1.2.1&q=80&w=1920"));
        0x2::display::update_version<GoldenKey>(&mut v1);
        let (v3, v4) = 0x2::transfer_policy::new<GoldenKey>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<GoldenKey>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<GoldenKey>>(v3);
        0x2::transfer::public_transfer<0x2::display::Display<GoldenKey>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint_golden_key(arg0: &MinterCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) : GoldenKey {
        GoldenKey{
            id          : 0x2::object::new(arg6),
            name        : arg2,
            image_url   : arg4,
            description : arg3,
            attributes  : arg5,
        }
    }

    // decompiled from Move bytecode v6
}

