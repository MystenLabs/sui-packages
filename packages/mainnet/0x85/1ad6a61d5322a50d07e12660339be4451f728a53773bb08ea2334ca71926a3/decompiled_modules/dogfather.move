module 0x851ad6a61d5322a50d07e12660339be4451f728a53773bb08ea2334ca71926a3::dogfather {
    struct DOGFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGFATHER>(arg0, 6, b"Dogfather", b"The Dogfather", b"https://x.com/elonmusk/status/1839195677710008417", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogefather_5a9b5be70b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGFATHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGFATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

