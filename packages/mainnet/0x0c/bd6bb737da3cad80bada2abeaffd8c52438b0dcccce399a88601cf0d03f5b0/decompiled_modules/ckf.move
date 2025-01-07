module 0xcbd6bb737da3cad80bada2abeaffd8c52438b0dcccce399a88601cf0d03f5b0::ckf {
    struct CKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CKF>(arg0, 6, b"CKF", b"Carrot Fish", b"ugh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/carrot_fish_cc7c2b34d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

