module 0x3d0a1a9d25af16d3c092b73594967d88eb7b9b21ed01fd9dc16a4d5a783759fc::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 6, b"SSUI", b"Super Sui", b"There is a superhero in all of us, we just need to have the courage to wear a cape and mask", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733606694204.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

