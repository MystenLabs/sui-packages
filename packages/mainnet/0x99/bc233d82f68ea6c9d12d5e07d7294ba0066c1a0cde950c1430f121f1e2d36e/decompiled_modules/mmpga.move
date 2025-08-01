module 0x99bc233d82f68ea6c9d12d5e07d7294ba0066c1a0cde950c1430f121f1e2d36e::mmpga {
    struct MMPGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMPGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMPGA>(arg0, 6, b"MMPGA", b"MAKE MOVE PUMP GREAT AGAIN", b"You are taking too long to get to Move Pump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid5weyhj4erccgdfto7o3knhd5dezypkmpaalfpyoqevp5i7q52fq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMPGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMPGA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

