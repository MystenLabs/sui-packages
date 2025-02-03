module 0x454dafd86a0d8cce52abab36735bd5a55ed201ca26d2f076ce8162344dc59a97::pezi {
    struct PEZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEZI>(arg0, 6, b"PEZI", b"Pezi", x"496e74726f647563696e672050657a69206d656d65636f696e206f6e207468652053756920626c6f636b636861696e20e280932077686572652066756e206d6565747320696e6e6f766174696f6e21202450455a49206d656d65636f696e206272696e6773206120706c617966756c20747769737420746f20796f75722063727970746f20706f7274666f6c696f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738599085219.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEZI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEZI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

