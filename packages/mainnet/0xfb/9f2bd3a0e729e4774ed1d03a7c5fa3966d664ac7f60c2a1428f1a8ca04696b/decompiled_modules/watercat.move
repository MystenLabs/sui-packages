module 0xfb9f2bd3a0e729e4774ed1d03a7c5fa3966d664ac7f60c2a1428f1a8ca04696b::watercat {
    struct WATERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERCAT>(arg0, 6, b"WATERCAT", b"watercat", b"Diving into the meme world of Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730966032094.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATERCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

