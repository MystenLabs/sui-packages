module 0xabd1566252d424fc8bc1da8d60864f780bb454a1de2dd51f21f0ab84c10ed695::cof {
    struct COF has drop {
        dummy_field: bool,
    }

    fun init(arg0: COF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COF>(arg0, 6, b"COF", b"Condom Fish", b"This fish is stuck in a condom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2025_01_02_15_36_57_2d2e936c33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COF>>(v1);
    }

    // decompiled from Move bytecode v6
}

