module 0x7fb83e1a2f35dbba062d6bcdb29471c666f4aa7aea48a50fbd17dcb49c12863d::dead {
    struct DEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAD>(arg0, 11, b"DEAD", b"Dead Coin", b"The end is near!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/CgQoqef.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEAD>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

