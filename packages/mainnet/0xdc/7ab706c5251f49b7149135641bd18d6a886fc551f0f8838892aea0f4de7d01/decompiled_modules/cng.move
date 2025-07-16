module 0xdc7ab706c5251f49b7149135641bd18d6a886fc551f0f8838892aea0f4de7d01::cng {
    struct CNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CNG>(arg0, 6, b"CNG", b"CHICKEN NUGGET", b"Flying cars? Nah the Gegagedigedagedago chicken nugget meme is better", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_2_9932761c5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CNG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

