module 0x41c95ffd01e4a5b964c9bbcf61f64e6f4aedb5cb3a13b0654c37cc4098043c8e::cish {
    struct CISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CISH>(arg0, 6, b"CISH", b"CAT FISH CISH", b"CUTEST COMBINATION BETWEEN CAT AND FISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_23_44_50_e966507ee3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

