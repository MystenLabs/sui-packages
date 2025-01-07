module 0x162cc8e0a5b67a41e79f070fde0d676b28e644699ff8662249ba0b7a530b7092::ancient {
    struct ANCIENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANCIENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANCIENT>(arg0, 6, b"ANCIENT", b"The Art of Ancient", b"AI reimagining of the Art of Acient", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053602_b591c365a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANCIENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANCIENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

