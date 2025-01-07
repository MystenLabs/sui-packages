module 0x15f7114bc359ef42acd16a5394ecb4f4631b1ba26ba20732cf89917653fc2e59::russell {
    struct RUSSELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSELL>(arg0, 9, b"RUSSELL", b"Russell Dog", b"Brian Armstrong's Dog Come Sui Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844731134938079245/4dcY02Pr_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUSSELL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSELL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSSELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

