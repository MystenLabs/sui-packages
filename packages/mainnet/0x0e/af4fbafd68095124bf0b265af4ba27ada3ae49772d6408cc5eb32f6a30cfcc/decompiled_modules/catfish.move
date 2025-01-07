module 0xeaf4fbafd68095124bf0b265af4ba27ada3ae49772d6408cc5eb32f6a30cfcc::catfish {
    struct CATFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFISH>(arg0, 6, b"CATFISH", b"Cat the Fish", b"XIN XAO XUN XENM XUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catfish_06f7cb3fac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

