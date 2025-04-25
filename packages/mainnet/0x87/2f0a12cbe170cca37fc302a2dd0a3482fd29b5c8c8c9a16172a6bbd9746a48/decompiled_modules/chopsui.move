module 0x872f0a12cbe170cca37fc302a2dd0a3482fd29b5c8c8c9a16172a6bbd9746a48::chopsui {
    struct CHOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPSUI>(arg0, 6, b"CHOPSUI", b"CHOP SUI", b"Decentralized with a side of delicious", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CD_94_A88_E_A85_F_4726_A729_9_EDD_880_D9_DEF_25441dbd4f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

