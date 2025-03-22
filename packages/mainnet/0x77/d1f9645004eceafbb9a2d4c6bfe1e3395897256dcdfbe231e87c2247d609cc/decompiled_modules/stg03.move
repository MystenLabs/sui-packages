module 0x77d1f9645004eceafbb9a2d4c6bfe1e3395897256dcdfbe231e87c2247d609cc::stg03 {
    struct STG03 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG03, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG03>(arg0, 9, b"STG03", b"STG_03", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.dextools.io/resources/tokens/logos/ether/0xaaee1a9723aadb7afa2810263653a34ba2c21c7a.webp?1711817392865"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STG03>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG03>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STG03>>(v2);
    }

    // decompiled from Move bytecode v6
}

