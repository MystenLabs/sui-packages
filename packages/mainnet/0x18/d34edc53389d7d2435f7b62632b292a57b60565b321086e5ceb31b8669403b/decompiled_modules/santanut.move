module 0x18d34edc53389d7d2435f7b62632b292a57b60565b321086e5ceb31b8669403b::santanut {
    struct SANTANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTANUT>(arg0, 6, b"SANTANUT", b"Santa Nut SUI", b"Let's celebrate Christmas and New Year together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_164857_439_7a552cf10a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTANUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTANUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

