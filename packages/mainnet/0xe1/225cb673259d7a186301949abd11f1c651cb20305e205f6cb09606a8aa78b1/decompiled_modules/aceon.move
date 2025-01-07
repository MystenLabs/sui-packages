module 0xe1225cb673259d7a186301949abd11f1c651cb20305e205f6cb09606a8aa78b1::aceon {
    struct ACEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACEON>(arg0, 6, b"ACEON", b"Sui Aceon", b"ACEON - The ultimate cat memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002794_4486775635.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

