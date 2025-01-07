module 0x5d557f1341ccb24f255a2507b1ce98a417b5dd813c875fe106d9a8cd329fd110::max {
    struct MAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX>(arg0, 6, b"MAX", b"MAXIMUS", b"Maximus : The toughest cat on $SUI! Fearless, rough, and leading the crypto rebellion. Join the chaos and rise with Maximus!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/213123_72d530cb97.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

