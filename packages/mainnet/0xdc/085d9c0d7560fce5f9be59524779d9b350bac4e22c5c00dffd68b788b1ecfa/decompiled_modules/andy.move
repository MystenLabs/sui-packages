module 0xdc085d9c0d7560fce5f9be59524779d9b350bac4e22c5c00dffd68b788b1ecfa::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 6, b"ANDY", b"Andy's Clun", x"506565702074686973204d454d4520626c6f636b636861696e2074656368210a49742773207368616b696e67207468696e6773207570206269672074696d652c0a72696768743f20526964696e672068696768206f6e2074686f73650a646563656e7472616c697a65642077617665732c2073636f72696e672074686f73650a5065706576657273652077696e7321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/acaf49d4_c7d0_456e_8514_b034bcff8ec0_417f0bea49.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

