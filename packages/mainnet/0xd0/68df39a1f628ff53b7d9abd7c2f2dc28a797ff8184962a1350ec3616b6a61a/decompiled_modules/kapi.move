module 0xd068df39a1f628ff53b7d9abd7c2f2dc28a797ff8184962a1350ec3616b6a61a::kapi {
    struct KAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPI>(arg0, 6, b"KAPI", b"KAPI ON SUI", x"4a7573742061206368696c6c204b617069206f6e205375692e0a4b6170692d6c6965766520696e20736f6d657468696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ee_F_Qrj_Nb_400x400_e8e6ce4df1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

