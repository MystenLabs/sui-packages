module 0x2246363a812129bd4d67a36ce48a53b5cbfb6af6f4b4f00496f0425d7dfd67b9::satosui {
    struct SATOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSUI>(arg0, 6, b"SATOSUI", b"SATOSHI NAKAMOTO", x"5341544f53554920544845204e4557204d454d45434f494e2043524541544544204259205341544f534849204e414b414d4f544f212121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_7bd8d60d59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

