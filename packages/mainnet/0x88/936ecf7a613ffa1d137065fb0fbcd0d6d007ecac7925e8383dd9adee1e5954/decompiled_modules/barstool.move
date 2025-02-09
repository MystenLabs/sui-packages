module 0x88936ecf7a613ffa1d137065fb0fbcd0d6d007ecac7925e8383dd9adee1e5954::barstool {
    struct BARSTOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARSTOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARSTOOL>(arg0, 9, b"barstool", b"Barstool Sports", b"Viva La Stool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQ95aeVVMoRG36jNCZ1vx54YKET1Ak8HwSpT5x99xK4pf")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARSTOOL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARSTOOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARSTOOL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

