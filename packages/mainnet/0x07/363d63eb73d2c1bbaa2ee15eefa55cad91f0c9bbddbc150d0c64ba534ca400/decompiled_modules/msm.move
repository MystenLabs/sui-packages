module 0x7363d63eb73d2c1bbaa2ee15eefa55cad91f0c9bbddbc150d0c64ba534ca400::msm {
    struct MSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSM>(arg0, 6, b"MSM", b"Must stop Murad", b"Fan boy and celebrate the success of Murad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/792_DFEBD_AB_12_478_B_9983_FDC_05962_F1_B1_7a1d8922bb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

