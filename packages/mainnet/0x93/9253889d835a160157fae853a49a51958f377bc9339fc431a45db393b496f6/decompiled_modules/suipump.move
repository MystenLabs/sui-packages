module 0x939253889d835a160157fae853a49a51958f377bc9339fc431a45db393b496f6::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/IMG_9504-KgJoL3ac0eGQQ4FFzV1ipOoW8iYn5M.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/IMG_9504-KgJoL3ac0eGQQ4FFzV1ipOoW8iYn5M.jpeg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 9, b"SUIPUMP", x"53554950554d50e2808b", x"53756950756d70204f6e20546f700a0a582068747470733a2f2f782e636f6d2f73756970756d705f73756d700a54656c656772616d2068747470733a2f2f742e6d652f53756950756d705f53554d500a576562736974652068747470733a2f2f73756970756d702e6f7267", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPUMP>>(0x2::coin::mint<SUIPUMP>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

