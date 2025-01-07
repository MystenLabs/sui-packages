module 0xc212709bc9baba57e870cd93fb855f479baf57e6eaf6a7f96e3db336d976f029::twodog {
    struct TWODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWODOG>(arg0, 6, b"TWODOG", b"Two a dog", b"hello i coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_6_0b6fe6314b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

