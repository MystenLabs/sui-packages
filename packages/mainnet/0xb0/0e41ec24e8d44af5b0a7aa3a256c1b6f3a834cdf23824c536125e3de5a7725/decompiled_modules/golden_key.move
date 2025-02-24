module 0xb00e41ec24e8d44af5b0a7aa3a256c1b6f3a834cdf23824c536125e3de5a7725::golden_key {
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
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        let v6 = 0x2::display::new_with_fields<GoldenKey>(&v0, v2, v4, arg1);
        0x2::display::update_version<GoldenKey>(&mut v6);
        let (v7, v8) = 0x2::transfer_policy::new<GoldenKey>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<GoldenKey>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<GoldenKey>>(v7);
        0x2::transfer::public_transfer<0x2::display::Display<GoldenKey>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint_golden_key(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : GoldenKey {
        GoldenKey{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            image_url   : arg3,
            description : arg2,
            attributes  : arg4,
        }
    }

    public fun mint_golden_key2(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::transfer_policy::TransferPolicy<GoldenKey>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = GoldenKey{
            id          : 0x2::object::new(arg7),
            name        : arg3,
            image_url   : arg5,
            description : arg4,
            attributes  : arg6,
        };
        let (v1, v2) = 0x2::kiosk::new(arg7);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<GoldenKey>(&mut v4, &v3, arg2, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg1);
    }

    // decompiled from Move bytecode v6
}

