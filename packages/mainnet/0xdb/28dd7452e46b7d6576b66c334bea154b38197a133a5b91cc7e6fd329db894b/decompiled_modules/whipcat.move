module 0xdb28dd7452e46b7d6576b66c334bea154b38197a133a5b91cc7e6fd329db894b::whipcat {
    struct WHIPCAT has drop {
        dummy_field: bool,
    }

    fun field(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg0)) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            if (v3 == 124) {
                if (v1 == arg1) {
                    return v0
                };
                v1 = v1 + 1;
                v0 = b"";
            } else {
                0x1::vector::push_back<u8>(&mut v0, v3);
            };
            v2 = v2 + 1;
        };
        if (v1 == arg1) {
            v0
        } else {
            b""
        }
    }

    fun init(arg0: WHIPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"WHIPCAT|WHIPCAT||https://cdn.dexscreener.com/cms/images/dE0yTirOot5gle2q?width=128&height=128&fit=crop&quality=95&format=auto";
        let v1 = field(&v0, 3);
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(v1)))
        };
        let (v3, v4) = 0x2::coin::create_currency<WHIPCAT>(arg0, 9, field(&v0, 0), field(&v0, 1), field(&v0, 2), v2, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHIPCAT>>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHIPCAT>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

