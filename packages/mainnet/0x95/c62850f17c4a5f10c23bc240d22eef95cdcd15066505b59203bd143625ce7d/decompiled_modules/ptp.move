module 0x95c62850f17c4a5f10c23bc240d22eef95cdcd15066505b59203bd143625ce7d::ptp {
    struct PTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTP>(arg0, 6, b"PTP", b"Po The Panda", b"yesterday is history, tomorrow is a mystery, but today is a gift. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PTP_e019e69f5b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTP>>(v1);
    }

    // decompiled from Move bytecode v6
}

