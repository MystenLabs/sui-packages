module 0x80947db47304ec3dc14c531e37284bb35ad249b843122adb8f55ded3b93dad1e::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 6, b"GME", b"GameStop", x"4561726c792041646f70746572206f662024535549202c20444556206c61756e636865642024474d45206f6e2050756c7365436861696e2028646964203132342e3030302520616b6120313234307820696e2066697273742032346829200a0a426967207468696e677320636f6d696e6720757020666f722074686520535549200a0a466972737420474d4520436f696e206f6e2053554920426c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GME_SUI_d69886c7a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GME>>(v1);
    }

    // decompiled from Move bytecode v6
}

