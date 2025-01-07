module 0xd7858421aa8f1bb9797e059568db1d66933ee35882cbfd0c742113aaaf71d80f::suiga {
    struct SUIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGA>(arg0, 6, b"SUIGA", b"MARBLE ON SUI", b"Players compete with other players in marble races, communicate, and become winners & get rewarded on $SUIGA. Integrated with SUI Network developed by Saga.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_13_37_44_3295f36e1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

