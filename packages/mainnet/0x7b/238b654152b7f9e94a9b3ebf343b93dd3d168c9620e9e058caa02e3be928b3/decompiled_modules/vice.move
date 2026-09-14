module 0x7b238b654152b7f9e94a9b3ebf343b93dd3d168c9620e9e058caa02e3be928b3::vice {
    struct VICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/GjMfAfYg_400x400-Mpzmyy6OBhPlIrr41SUgfKFHRkcEOj.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/GjMfAfYg_400x400-Mpzmyy6OBhPlIrr41SUgfKFHRkcEOj.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<VICE>(arg0, 9, b"VICE", x"56494345e2808b", x"5669636546756e0a0a582068747470733a2f2f782e636f6d2f5669636546756e0a54656c656772616d2068747470733a2f2f742e6d652f5669636546756e0a576562736974652068747470733a2f2f7669636566756e2e636f6d", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VICE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VICE>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<VICE>>(0x2::coin::mint<VICE>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

