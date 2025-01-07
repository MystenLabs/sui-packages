module 0xc1fbda93b280f038cf57899dcaaf8a172045e6b877157c288cf9b56fe1dcedd5::suibas {
    struct SUIBAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAS>(arg0, 6, b"SUIBAS", b"SUIBA!!", b"The secret ingredient has always been a blue dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_015029768_19a2329dd6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

