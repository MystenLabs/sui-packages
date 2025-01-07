module 0x5059f9717e50685b91ac51d3fa2c137d4d054dd1ca002f27863215bb4a64a1bb::MELON {
    struct MELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELON>(arg0, 9, b"MELON", b"MELON", b"MELON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1737575093168201728/Cq8oFxqM_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MELON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MELON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

