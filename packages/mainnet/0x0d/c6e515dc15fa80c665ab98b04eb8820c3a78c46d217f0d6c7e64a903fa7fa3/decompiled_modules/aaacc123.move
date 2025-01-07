module 0xdc6e515dc15fa80c665ab98b04eb8820c3a78c46d217f0d6c7e64a903fa7fa3::aaacc123 {
    struct AAACC123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAACC123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAACC123>(arg0, 6, b"Aaacc123", b"Aaacc", b"1234", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_Ubgzfgg_400x400_92d0f8f2f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAACC123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAACC123>>(v1);
    }

    // decompiled from Move bytecode v6
}

