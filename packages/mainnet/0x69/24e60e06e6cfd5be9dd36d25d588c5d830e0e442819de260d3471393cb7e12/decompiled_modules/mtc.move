module 0x6924e60e06e6cfd5be9dd36d25d588c5d830e0e442819de260d3471393cb7e12::mtc {
    struct MTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTC>(arg0, 6, b"Mtc", b"Mythical ", b"The Phoenix one of the mythical creatures ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731253535717.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

