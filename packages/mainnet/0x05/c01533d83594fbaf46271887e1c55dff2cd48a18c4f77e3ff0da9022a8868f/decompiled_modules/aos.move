module 0x5c01533d83594fbaf46271887e1c55dff2cd48a18c4f77e3ff0da9022a8868f::aos {
    struct AOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOS>(arg0, 6, b"AOS", b"Aptos on sui", b"Aptos on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735980540526.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

