module 0xfb07f807a33fbe513862960c501c17bb805a794519fa8987d32f745a55a946c5::amir {
    struct AMIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMIR>(arg0, 2, b"AMIR", b"AMIR (UBER EATS)", b"Two dolla dolla tip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_Aa17XNo3ClFxRgVP7AkMDN6iqIh7b-Ls0A&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AMIR>(&mut v2, 222222222200, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMIR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

