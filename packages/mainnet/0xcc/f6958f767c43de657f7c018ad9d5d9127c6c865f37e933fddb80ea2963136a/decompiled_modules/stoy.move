module 0xccf6958f767c43de657f7c018ad9d5d9127c6c865f37e933fddb80ea2963136a::stoy {
    struct STOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOY>(arg0, 6, b"STOY", b"STONKGUY", x"0a53544f4e4b4755592046495253542053544f4e4b204f4e5355492e0a464952535420544f4b454e204255524e204d432031304b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004151_a77ce00fa8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

