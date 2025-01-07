module 0x7891dcf496e69c0a4aa4857b96436c8aade4b5432ca2e9ac11d0e8f6fb1cb19b::babbyhippo {
    struct BABBYHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABBYHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABBYHIPPO>(arg0, 6, b"BabbyHippo", b"Babby Hippo", b"No Cats, No Dogs Only Hippo! Baby Hippo was born on BNB Chain, to promote this wave with the mission of spreading the cuteness of hippos and join hands to raise awareness of protecting wild animals of people around the world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_15_06_17_41857f755b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABBYHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABBYHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

