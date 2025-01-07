module 0xb324e7af2b3f525d0973fb38533fbca27a7188fbd17ca88ca38804b3dc65b012::dogwif {
    struct DOGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIF>(arg0, 6, b"Dogwif", b"dog", b"wog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732613982311.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

