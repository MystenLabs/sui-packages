module 0x301dced39678bc907f3763666dc8c74e20b0561aa820e2629dc1f2f5ae740fc3::bobe {
    struct BOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBE>(arg0, 6, b"BOBE", b"Bobe on Sui", b"BOBE The turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985012843.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

