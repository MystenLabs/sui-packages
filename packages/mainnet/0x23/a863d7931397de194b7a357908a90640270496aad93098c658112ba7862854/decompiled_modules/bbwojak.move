module 0x23a863d7931397de194b7a357908a90640270496aad93098c658112ba7862854::bbwojak {
    struct BBWOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBWOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBWOJAK>(arg0, 6, b"BBWOJAK", b"BABY WOJAK", b"Baby wojakians rise!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6755_9abafe0558.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBWOJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBWOJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

