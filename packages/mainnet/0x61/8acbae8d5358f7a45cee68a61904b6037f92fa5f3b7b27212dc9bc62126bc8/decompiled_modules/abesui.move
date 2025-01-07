module 0x618acbae8d5358f7a45cee68a61904b6037f92fa5f3b7b27212dc9bc62126bc8::abesui {
    struct ABESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABESUI>(arg0, 6, b"ABESUI", b"Abe The Bald Eagle", b"Hey Im Abe - Americas #1 Bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_230807_546_69a4aeb9c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

