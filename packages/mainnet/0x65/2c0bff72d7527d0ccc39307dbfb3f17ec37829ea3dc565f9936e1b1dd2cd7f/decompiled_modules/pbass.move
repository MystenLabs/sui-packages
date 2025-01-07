module 0x652c0bff72d7527d0ccc39307dbfb3f17ec37829ea3dc565f9936e1b1dd2cd7f::pbass {
    struct PBASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBASS>(arg0, 6, b"PBASS", b"Punk Bass", b"The Most Badass of Basses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733229625793.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

