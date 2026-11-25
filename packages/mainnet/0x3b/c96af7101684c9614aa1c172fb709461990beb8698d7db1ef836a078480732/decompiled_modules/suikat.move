module 0x3bc96af7101684c9614aa1c172fb709461990beb8698d7db1ef836a078480732::suikat {
    struct SUIKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795565910598-2d99ae9e904f880eef8feb4e61882b79.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795565910598-2d99ae9e904f880eef8feb4e61882b79.jpg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<SUIKAT>(arg0, 9, b"SUIKAT", b"SUIKAT", b"SUI KAT", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<SUIKAT>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKAT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKAT>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

