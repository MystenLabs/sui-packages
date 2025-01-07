module 0x848339696b57f36bd70f7a15a71bf2eccdf6c29e92a2b730a7e6173b76446941::pumpe {
    struct PUMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPE>(arg0, 6, b"PUMPE", b"Pumpe on Sui", b"Pumpes Tokenomics: Built to Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_18_77355edbbd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

