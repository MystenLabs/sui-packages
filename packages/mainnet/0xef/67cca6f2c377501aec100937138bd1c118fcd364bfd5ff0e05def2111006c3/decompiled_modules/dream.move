module 0xef67cca6f2c377501aec100937138bd1c118fcd364bfd5ff0e05def2111006c3::dream {
    struct DREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREAM>(arg0, 6, b"DREAM", b"ONE SUI ONE DREAM", b"I have a Dream, That One Day I WILL TURN ONE SUI INTO A $DREAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_043246_935_bb856cabb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

