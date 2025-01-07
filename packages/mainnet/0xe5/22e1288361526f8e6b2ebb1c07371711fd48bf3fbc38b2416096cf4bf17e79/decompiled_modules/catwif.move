module 0xe522e1288361526f8e6b2ebb1c07371711fd48bf3fbc38b2416096cf4bf17e79::catwif {
    struct CATWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWIF>(arg0, 6, b"CATWIF", b"Beanie Cat", b"Cat with a nice hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971106856.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

