module 0x8bfcf7f6c86dd2f1c626e5207244bdd3128ecf2a8635b6e41709ccca18e6755f::mozuku {
    struct MOZUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZUKU>(arg0, 6, b"Mozuku", b"The Real Name of Doge", b"We just found the real name of DOGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h8radhfp_12bb7b32d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOZUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

