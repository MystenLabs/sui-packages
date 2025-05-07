module 0xce7d09b0889366649cee2855fa86479a4d848f4391480c18d0f3c4c9ee9c4824::pakisboom {
    struct PAKISBOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAKISBOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAKISBOOM>(arg0, 6, b"PAKISBOOM", b"india bombs pakistan", b"What is this shit? Bombs, bombs, bombs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_05_06_19_23_06_67ca15b86f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAKISBOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAKISBOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

