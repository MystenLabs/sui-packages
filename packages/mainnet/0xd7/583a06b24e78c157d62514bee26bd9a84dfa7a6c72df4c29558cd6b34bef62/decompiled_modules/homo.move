module 0xd7583a06b24e78c157d62514bee26bd9a84dfa7a6c72df4c29558cd6b34bef62::homo {
    struct HOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMO>(arg0, 6, b"HOMO", b"HOMOSUI", b"HOMO mem sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_D_D_N_D_e1d8f88a5a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

