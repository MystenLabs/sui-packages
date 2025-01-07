module 0x804642c68199e5ff515e21a9fa1e3b4145665eba5ea54b22ee495cca7b79d0d7::elefantspidsmus {
    struct ELEFANTSPIDSMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEFANTSPIDSMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEFANTSPIDSMUS>(arg0, 6, b"ELEFANTSPIDSMUS", b"elefantspidsmus", b"a viral short-eared elephant shrew named elefantspidsmus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250101_035345_122_cd8e1b5a1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEFANTSPIDSMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEFANTSPIDSMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

