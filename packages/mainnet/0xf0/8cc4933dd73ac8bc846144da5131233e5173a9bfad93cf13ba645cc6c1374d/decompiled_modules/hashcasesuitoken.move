module 0xf08cc4933dd73ac8bc846144da5131233e5173a9bfad93cf13ba645cc6c1374d::hashcasesuitoken {
    struct HASHCASESUITOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASHCASESUITOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASHCASESUITOKEN>(arg0, 9, b"HST", b"Hashcase Sui Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://metadata-hashcase-admin.s3.us-east-2.amazonaws.com/nft-images/1759141172267-flower-9799036_1920.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HASHCASESUITOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASHCASESUITOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HASHCASESUITOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HASHCASESUITOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

