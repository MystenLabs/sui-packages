module 0x49b0d036ffdffbb9e9f84a9bc6b80f3d8c89a28535ea9d80a8e8dc817626e8::pengus {
    struct PENGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUS>(arg0, 6, b"PENGUS", b"Pengu Santa", b"The Santa Pengu family creates holiday-themed content, festive merchandise, adorable toys, and digital collectibles. We believe in the magic of the season and are here to help you rediscover the joy and wonder of your inner child. It may be a frosty Arctic wonderland, but youll feel cozy and loved with your new favorite penguin family this Christmas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5345_1bd473f19b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

