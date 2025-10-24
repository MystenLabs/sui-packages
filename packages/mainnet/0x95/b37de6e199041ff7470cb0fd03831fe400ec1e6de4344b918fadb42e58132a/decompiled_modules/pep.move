module 0x95b37de6e199041ff7470cb0fd03831fe400ec1e6de4344b918fadb42e58132a::pep {
    struct PEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEP>(arg0, 6, b"PEP", b"PEP3", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1761294770190.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

