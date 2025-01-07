module 0x80ab66cc50bbd72b85f038d81b2c2da47ceda01ae64401c314edf26e8aed567f::testo {
    struct TESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTO>(arg0, 9, b"TARZAN", b"Tarzan Token", b"This token burns on purchase.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTO>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun purchase_and_burn(arg0: &mut 0x2::coin::TreasuryCap<TESTO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTO>(arg0, arg2, @0x0, arg3);
    }

    // decompiled from Move bytecode v6
}

