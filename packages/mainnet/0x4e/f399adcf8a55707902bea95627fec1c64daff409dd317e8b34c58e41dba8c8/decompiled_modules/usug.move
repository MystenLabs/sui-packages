module 0x4ef399adcf8a55707902bea95627fec1c64daff409dd317e8b34c58e41dba8c8::usug {
    struct USUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: USUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USUG>(arg0, 6, b"USUG", b"U SELL U GAY", b"Selling your $USELLUGAY may not align with your investment goals, but it's important to avoid passing judgment on others based solely on financial decisions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ay_Sz_tw_O_400x400_9e57af34b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

