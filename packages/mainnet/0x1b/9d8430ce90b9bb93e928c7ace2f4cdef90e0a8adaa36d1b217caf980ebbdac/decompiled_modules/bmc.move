module 0x1b9d8430ce90b9bb93e928c7ace2f4cdef90e0a8adaa36d1b217caf980ebbdac::bmc {
    struct BMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMC>(arg0, 9, b"BMC", b"BMW CAR ", b"Full of power with originality", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05ffbaaa-4532-4019-8fba-2f10ced56739.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

