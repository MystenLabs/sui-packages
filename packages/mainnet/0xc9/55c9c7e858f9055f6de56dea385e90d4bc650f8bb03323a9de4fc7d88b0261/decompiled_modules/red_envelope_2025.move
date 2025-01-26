module 0xc955c9c7e858f9055f6de56dea385e90d4bc650f8bb03323a9de4fc7d88b0261::red_envelope_2025 {
    struct RED_ENVELOPE_2025 has drop {
        dummy_field: bool,
    }

    struct Airdrop has copy, drop {
        id: 0x2::object::ID,
        kind: u8,
        recipient: address,
    }

    struct RedEnvelope2025 has store, key {
        id: 0x2::object::UID,
        kind: u8,
    }

    fun new(arg0: &0xc955c9c7e858f9055f6de56dea385e90d4bc650f8bb03323a9de4fc7d88b0261::admin::AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : RedEnvelope2025 {
        RedEnvelope2025{
            id   : 0x2::object::new(arg2),
            kind : arg1,
        }
    }

    public fun airdrop(arg0: &0xc955c9c7e858f9055f6de56dea385e90d4bc650f8bb03323a9de4fc7d88b0261::admin::AdminCap, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0, arg1, arg3);
        let v1 = Airdrop{
            id        : 0x2::object::id<RedEnvelope2025>(&v0),
            kind      : arg1,
            recipient : arg2,
        };
        0x2::event::emit<Airdrop>(v1);
        0x2::transfer::transfer<RedEnvelope2025>(v0, arg2);
    }

    public fun batch_airdrop(arg0: &0xc955c9c7e858f9055f6de56dea385e90d4bc650f8bb03323a9de4fc7d88b0261::admin::AdminCap, arg1: u8, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            airdrop(arg0, arg1, arg3, arg4);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: RED_ENVELOPE_2025, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BuckYou Red Envelope 2025"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Go claim your shares at https://cny.buckyou.io !"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aqua-natural-grasshopper-705.mypinata.cloud/ipfs/Qmeyz3FijdgyR9AMqg84nzpQR4sXbZd1M4UBhQ9Dz99sYE"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cny.buckyou.io/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"buckyou"));
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = 0x2::package::claim<RED_ENVELOPE_2025>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<RedEnvelope2025>(&v5, v0, v2, arg1);
        0x2::display::update_version<RedEnvelope2025>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<RedEnvelope2025>>(v6, v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v4);
    }

    // decompiled from Move bytecode v6
}

