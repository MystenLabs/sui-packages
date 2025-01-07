module 0x71963709e8b9408c69eae441f230b9b9860007a9f668391191551fcdae362cde::fripo {
    struct FRIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIPO>(arg0, 6, b"FRIPO", b"Sui Fripo", b"Fripo - a unique pygmy multi-species hybrid, born from the fusion of two worlds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013987_b183acc10a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

