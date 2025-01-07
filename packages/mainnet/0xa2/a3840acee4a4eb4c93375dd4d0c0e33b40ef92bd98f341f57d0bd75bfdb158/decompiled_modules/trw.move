module 0xa2a3840acee4a4eb4c93375dd4d0c0e33b40ef92bd98f341f57d0bd75bfdb158::trw {
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

