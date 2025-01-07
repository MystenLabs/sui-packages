module 0x83bbab6b4fa3907ff90f47d10141f0b6fd69ac2d5810adabedf6453b989b822d::suiflop {
    struct SUIFLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFLOP>(arg0, 6, b"SUIFLOP", b"FlipFlops on SUI", x"0a2343484541502023474f4f44202343554c54555245", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_Ri_F7_Ui7_400x400_364b402048.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

