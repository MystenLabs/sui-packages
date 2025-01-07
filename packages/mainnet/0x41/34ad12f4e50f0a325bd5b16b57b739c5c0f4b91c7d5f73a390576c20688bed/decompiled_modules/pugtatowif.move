module 0x4134ad12f4e50f0a325bd5b16b57b739c5c0f4b91c7d5f73a390576c20688bed::pugtatowif {
    struct PUGTATOWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGTATOWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGTATOWIF>(arg0, 6, b"PUGTATOWIF", b"Pugtato Wif Hat", b"It's a pugtato wif hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731174539450.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUGTATOWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGTATOWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

