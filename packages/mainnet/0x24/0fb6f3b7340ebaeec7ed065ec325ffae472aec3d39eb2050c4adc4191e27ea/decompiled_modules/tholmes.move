module 0x240fb6f3b7340ebaeec7ed065ec325ffae472aec3d39eb2050c4adc4191e27ea::tholmes {
    struct THOLMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOLMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THOLMES>(arg0, 6, b"THOLMES", b"terminal of holmes", b"Memecoin detective agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/345345_2b836262b0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THOLMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THOLMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

