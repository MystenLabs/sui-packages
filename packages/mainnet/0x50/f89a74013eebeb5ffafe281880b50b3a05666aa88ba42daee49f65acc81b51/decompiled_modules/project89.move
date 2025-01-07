module 0x50f89a74013eebeb5ffafe281880b50b3a05666aa88ba42daee49f65acc81b51::project89 {
    struct PROJECT89 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROJECT89, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROJECT89>(arg0, 6, b"PROJECT89", b"Project89 Sui", b"This is what we will do to all of culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001800_92404f5487.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROJECT89>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROJECT89>>(v1);
    }

    // decompiled from Move bytecode v6
}

