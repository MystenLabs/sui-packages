module 0xf5fa3b986887447a5d569a00b262bc00a3e35771394d46e29f9b698caffa29a3::trw {
    struct TRW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRW>(arg0, 6, b"TRW", b"The real world", b"The official token on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1884_eef729c5ae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRW>>(v1);
    }

    // decompiled from Move bytecode v6
}

