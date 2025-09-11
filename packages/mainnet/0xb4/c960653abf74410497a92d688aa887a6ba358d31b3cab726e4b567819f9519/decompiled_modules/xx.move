module 0xb4c960653abf74410497a92d688aa887a6ba358d31b3cab726e4b567819f9519::xx {
    struct XX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/wwts-V_8DCFevm8j5yn5JHVcusG9g3gjGMVuHJNv-i8";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/wwts-V_8DCFevm8j5yn5JHVcusG9g3gjGMVuHJNv-i8"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<XX>(arg0, 9, trim_right(b"xx"), trim_right(b"xx  "), trim_right(b"556"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XX>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XX>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XX>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

