module 0xcb0f241226a2e7470fdc76a3bcfb2fab74b6eac7fe0c7055a17f2f618b02d25b::bx1 {
    struct BX1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BX1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BX1>(arg0, 6, b"BX1", b"GO BIKE ME", b"By cycling from one point to another, users get a reward in $BX1, also be able to become movement for a healthy lifestyle. #RideToEarn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_01_29_d9b7a85799.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BX1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BX1>>(v1);
    }

    // decompiled from Move bytecode v6
}

