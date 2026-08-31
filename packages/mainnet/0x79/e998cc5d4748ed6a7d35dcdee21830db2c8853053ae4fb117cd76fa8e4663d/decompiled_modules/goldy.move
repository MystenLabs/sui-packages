module 0x79e998cc5d4748ed6a7d35dcdee21830db2c8853053ae4fb117cd76fa8e4663d::goldy {
    struct GOLDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/gold-token-pfp-bWmjeti1l3WE6fiZg7MrpBHpHMTdth.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/gold-token-pfp-bWmjeti1l3WE6fiZg7MrpBHpHMTdth.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<GOLDY>(arg0, 9, b"GOLDY", b"gold", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDY>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<GOLDY>>(0x2::coin::mint<GOLDY>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

