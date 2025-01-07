module 0x9eb35e661bbdca24755785536f982200d081dfb4b04882c9ed7f61d2d5c71f11::suiseeks {
    struct SUISEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEEKS>(arg0, 6, b"Suiseeks", b"Mr. Suiseeks", b"I'm Mr. Suiseeks, look at Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu_e0dd9281c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

