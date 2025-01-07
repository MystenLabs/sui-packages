module 0x3442a817c8f95fb0713ac2d3ca2ced104814b56443714492d4a901d9e887b206::genies {
    struct GENIES has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GENIES>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GENIES>>(0x2::coin::mint<GENIES>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GENIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENIES>(arg0, 6, b"GENIES", b"SUI Genie", b"What's your three wishes?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FMGA_LOGO_2_6_4c08790ed5.jpg&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENIES>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GENIES>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENIES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

