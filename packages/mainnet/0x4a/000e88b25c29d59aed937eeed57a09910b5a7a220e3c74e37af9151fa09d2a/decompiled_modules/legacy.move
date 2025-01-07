module 0x4a000e88b25c29d59aed937eeed57a09910b5a7a220e3c74e37af9151fa09d2a::legacy {
    struct LEGACY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGACY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGACY>(arg0, 9, b"LEGACY", b"Legacy", b"Legacy of MAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1847373953792430086/0UZ6u1re.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LEGACY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGACY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGACY>>(v1);
    }

    // decompiled from Move bytecode v6
}

