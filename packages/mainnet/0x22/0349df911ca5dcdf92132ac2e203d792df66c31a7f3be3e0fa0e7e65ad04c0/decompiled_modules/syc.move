module 0x220349df911ca5dcdf92132ac2e203d792df66c31a7f3be3e0fa0e7e65ad04c0::syc {
    struct SYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYC>(arg0, 6, b"SYC", b"Suiyan Cat", b"the most annoying cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/em_Pm_5_O5_400x400_b61b83371f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYC>>(v1);
    }

    // decompiled from Move bytecode v6
}

