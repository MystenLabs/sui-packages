module 0x3731dd305c177a7edc69b2e8a3f8e8450df72809feda0690cae63cceb53ddc81::purps {
    struct PURPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURPS>(arg0, 6, b"PURPS", b"PURP on SUI", b"Hello, I'am Purp ur new fren ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241201_200905_124_719d9ae759.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

