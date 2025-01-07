module 0x1b2554dec97be261693efd39e2ccb9571ca493449b68e1647130b16dfa89ebfa::jkajsn {
    struct JKAJSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKAJSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKAJSN>(arg0, 9, b"JKAJSN", b"jdndn", b"jsnsbb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32f2b725-d70f-48f0-bccf-a87e8d860248.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKAJSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JKAJSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

