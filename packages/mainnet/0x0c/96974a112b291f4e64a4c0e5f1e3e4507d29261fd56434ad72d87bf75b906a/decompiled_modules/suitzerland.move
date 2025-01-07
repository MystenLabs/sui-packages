module 0xc96974a112b291f4e64a4c0e5f1e3e4507d29261fd56434ad72d87bf75b906a::suitzerland {
    struct SUITZERLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITZERLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITZERLAND>(arg0, 9, b"SUITZERLAND", b"SUITZERLAND", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/e/e7/Flag_of_Switzerland_-_2.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITZERLAND>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITZERLAND>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITZERLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

