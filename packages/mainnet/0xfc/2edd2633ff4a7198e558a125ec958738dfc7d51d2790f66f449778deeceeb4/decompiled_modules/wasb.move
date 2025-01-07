module 0xfc2edd2633ff4a7198e558a125ec958738dfc7d51d2790f66f449778deeceeb4::wasb {
    struct WASB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASB>(arg0, 6, b"Wasb", b"WE ARE SO BACK", b"We are so back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8015_5e8d019fe7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASB>>(v1);
    }

    // decompiled from Move bytecode v6
}

