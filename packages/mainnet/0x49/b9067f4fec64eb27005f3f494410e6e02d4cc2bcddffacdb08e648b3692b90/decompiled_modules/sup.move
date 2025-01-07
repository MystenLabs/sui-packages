module 0x49b9067f4fec64eb27005f3f494410e6e02d4cc2bcddffacdb08e648b3692b90::sup {
    struct SUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUP>(arg0, 6, b"SUP", b"SuiPup", b"Doge-inspired, but with a Sui twist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipup_11255612ab.bin")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

