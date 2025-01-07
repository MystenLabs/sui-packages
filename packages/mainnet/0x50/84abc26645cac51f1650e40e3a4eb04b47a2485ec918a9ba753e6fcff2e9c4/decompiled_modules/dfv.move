module 0x5084abc26645cac51f1650e40e3a4eb04b47a2485ec918a9ba753e6fcff2e9c4::dfv {
    struct DFV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFV>(arg0, 6, b"DFV", b"deepfuckingvalue", b"roaring kitty of president", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241012_193755_567_99377528af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFV>>(v1);
    }

    // decompiled from Move bytecode v6
}

