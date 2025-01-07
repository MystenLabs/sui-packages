module 0xff9a0123987096ea87c32716cae460708ae41441a83864d3df1480e679c8bcd2::zazu {
    struct ZAZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAZU>(arg0, 6, b"Zazu", b"Zazu Cat", b"The goated cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0586_3bff54b22e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

