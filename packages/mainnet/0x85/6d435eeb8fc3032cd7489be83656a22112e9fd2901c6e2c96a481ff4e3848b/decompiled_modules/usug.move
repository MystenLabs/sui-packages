module 0x856d435eeb8fc3032cd7489be83656a22112e9fd2901c6e2c96a481ff4e3848b::usug {
    struct USUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: USUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USUG>(arg0, 6, b"USUG", b"U SELL U GAY", b"NO SITE NO TWITTER NO TELEGRAM JUST NOT GAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ay_Sz_tw_O_400x400_2c4e2b80ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

