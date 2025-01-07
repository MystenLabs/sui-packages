module 0xac0b49ba18e49f1d5aa803546d7ba6cb332dfbd59a8a318ed0439a6341a8cdb5::TYPUS {
    struct TYPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYPUS>(arg0, 9, b"TYPUS", b"TYPUS FINANCE", b"TYPUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icons.llamao.fi/icons/protocols/typus-finance?w=48&h=48")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYPUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYPUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TYPUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TYPUS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

