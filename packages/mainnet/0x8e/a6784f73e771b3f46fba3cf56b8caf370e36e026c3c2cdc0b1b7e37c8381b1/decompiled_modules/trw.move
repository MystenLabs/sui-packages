module 0x8ea6784f73e771b3f46fba3cf56b8caf370e36e026c3c2cdc0b1b7e37c8381b1::trw {
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

