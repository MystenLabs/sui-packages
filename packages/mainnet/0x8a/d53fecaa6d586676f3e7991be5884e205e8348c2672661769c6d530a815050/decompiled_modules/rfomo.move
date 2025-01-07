module 0x8ad53fecaa6d586676f3e7991be5884e205e8348c2672661769c6d530a815050::rfomo {
    struct RFOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RFOMO>(arg0, 6, b"Rfomo", b"retail fomo", b"just for fun let it run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731551208173.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RFOMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFOMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

