module 0x5752e3b4a54617f7cb435f828754f4924a933a5ac3238d7d99afc5f1038b5dee::vitalolz {
    struct VITALOLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: VITALOLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VITALOLZ>(arg0, 6, b"VITALOLZ", b"VitaLolz", b"Say hello to VitaLolz- wild new identity, hilariously reborn as a memecoin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029603_01c3fd509f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VITALOLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VITALOLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

