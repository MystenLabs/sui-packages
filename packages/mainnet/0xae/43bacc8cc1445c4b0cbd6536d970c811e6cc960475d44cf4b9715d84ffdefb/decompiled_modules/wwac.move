module 0xae43bacc8cc1445c4b0cbd6536d970c811e6cc960475d44cf4b9715d84ffdefb::wwac {
    struct WWAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWAC>(arg0, 6, b"WWAC", b"QQCC", b"ELEPHANTBTCA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/52e4d1424f5aa914f1dc8460962e33791c3ad6e04e5074417d2e72d2954ac5_640_c654fa225c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

