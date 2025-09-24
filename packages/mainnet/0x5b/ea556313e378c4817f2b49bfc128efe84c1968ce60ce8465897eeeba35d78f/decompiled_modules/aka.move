module 0x5bea556313e378c4817f2b49bfc128efe84c1968ce60ce8465897eeeba35d78f::aka {
    struct AKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKA>(arg0, 6, b"AKA", b"FK Tanjiro", b"AKAZA number one but dont buy token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1758704480265.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

