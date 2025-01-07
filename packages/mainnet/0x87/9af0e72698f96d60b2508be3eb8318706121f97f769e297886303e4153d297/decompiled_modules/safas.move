module 0x879af0e72698f96d60b2508be3eb8318706121f97f769e297886303e4153d297::safas {
    struct SAFAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFAS>(arg0, 6, b"Safas", b"ZDaszd", b"dasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chibi_Megumi_e32c21d89d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAFAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

