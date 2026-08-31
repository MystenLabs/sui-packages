module 0x2554ef48990f3d3a94ad05c4bf595c5baaadc5f344b6f249dac6c017c98d29e2::lock {
    struct LOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/lockin-WNma7uoJiLeRm5jG1VM2wiBQuYjC1n.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/lockin-WNma7uoJiLeRm5jG1VM2wiBQuYjC1n.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<LOCK>(arg0, 9, b"LOCK", b"lock in", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOCK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCK>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<LOCK>>(0x2::coin::mint<LOCK>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

