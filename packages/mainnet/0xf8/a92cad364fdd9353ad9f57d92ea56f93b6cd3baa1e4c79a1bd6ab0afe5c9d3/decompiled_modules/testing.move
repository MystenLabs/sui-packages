module 0xf8a92cad364fdd9353ad9f57d92ea56f93b6cd3baa1e4c79a1bd6ab0afe5c9d3::testing {
    struct TESTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTING>(arg0, 6, b"TESTING", b"testing", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b4999c57_450b_45a9_bd6d_f2a8a4628050_695d2ac69d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTING>>(v1);
    }

    // decompiled from Move bytecode v6
}

