module 0xb60749fc878c365a8e6c7aa5b621a363effd98f8cf6a74f1b7e7d0544fa1790::zilla {
    struct ZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZILLA>(arg0, 6, b"ZILLA", b"Monster BlueZilla", b"Monster Bluezilla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nb_z2_Ozb_S_Wi_J_7_ALD_Nk_Dn_Q_4d0d2ad535.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

