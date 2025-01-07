module 0x11d6f454ddd06baf30c43bb9bfcb400d14d9c6c3d8e9c626868bf0f204b66a67::pooh {
    struct POOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOH>(arg0, 6, b"POOH", b"PoohThug", b"$POOH is for the people it's time for the most recognizable bear in the world to claim his rightful position on the charts at the start of a life changing bull market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poohthug_845519a739.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOH>>(v1);
    }

    // decompiled from Move bytecode v6
}

