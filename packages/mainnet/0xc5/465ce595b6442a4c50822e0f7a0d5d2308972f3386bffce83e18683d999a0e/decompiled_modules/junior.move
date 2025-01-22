module 0xc5465ce595b6442a4c50822e0f7a0d5d2308972f3386bffce83e18683d999a0e::junior {
    struct JUNIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUNIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNIOR>(arg0, 6, b"JUNIOR", b"Donald Trump Jr.", b"The Only Official Donald Trump Jr. SUI Meme. $JUNIOR ( Trump's Son )", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_170425_120_dd39dc039d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUNIOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

