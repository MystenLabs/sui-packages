module 0x887268fa14026c54975e75f3bd1b11782da57ffee7de7ccd986cad8d9f703f6a::btrash {
    struct BTRASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTRASH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"006d97aa043d4f691f46033d30aff0f02d9c3a8be0b56df62bae062a6203540c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTRASH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Btrash      ")))), trim_right(b"Baby Trash                      "), trim_right(b"Baby Trash is where garbage meets gains! Were a fun, chaotic crypto community turning tiny messes into big opportunities. From stinky diapers to stacked wallets, our mission is to embrace the chaos, laugh at the madness, and ride the wildest waves of the crypto world together.                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTRASH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTRASH>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

