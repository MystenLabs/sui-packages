module 0xa334170681d19c5aa3759df4c0bf561f32bdb427ec0b3dd02994937ac65c884d::kreme {
    struct KREME has drop {
        dummy_field: bool,
    }

    fun init(arg0: KREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KREME>(arg0, 6, b"KREME", b"Kreme On Sui", b"KREME The 1st Ice Cream Memecoin Brand on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017617_f60c74df91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KREME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KREME>>(v1);
    }

    // decompiled from Move bytecode v6
}

