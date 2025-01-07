module 0xb9b478dc161bf7b25a00d961b93476cc6ebd839a15385e50c3ae19c2ecea7f12::blued {
    struct BLUED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUED>(arg0, 6, b"BLUED", b"Blue Eyed White Dragon", b"Blue-Eyed Dragon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9e4430aef11a8784fc00d652674a58d6_3307ea22e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUED>>(v1);
    }

    // decompiled from Move bytecode v6
}

