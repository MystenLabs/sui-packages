module 0x70fa514c6fe510436dfcbd7c9f86e44f0d63a777751cdee32b0c5ae6e61c5cfe::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/pfp-ZaopLOJ5qA7n5zIcUfTGy8baRlQl1G.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/pfp-ZaopLOJ5qA7n5zIcUfTGy8baRlQl1G.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<GOLD>(arg0, 9, b"GOLD", b"goldy", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLD>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<GOLD>>(0x2::coin::mint<GOLD>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

