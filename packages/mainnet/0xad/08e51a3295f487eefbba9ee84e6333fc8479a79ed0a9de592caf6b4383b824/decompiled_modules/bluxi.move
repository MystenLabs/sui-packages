module 0xad08e51a3295f487eefbba9ee84e6333fc8479a79ed0a9de592caf6b4383b824::bluxi {
    struct BLUXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUXI>(arg0, 6, b"BLUXI", b"SUI BLUXI", b"Meet Bluxi, the smallest but mightiest warrior in the crypto universe! Armed with muscles bigger than his market cap, Bluxi is always ready to throw punches at crypto FUD and fight off the bears in the market. Don't let his cute face fool youhe's tough enough to HODL through any dip and knock out the competition. Whether he's battling volatility or flexing his gains, Bluxi is the hero we need in this wild world of meme coins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241014_011426_4678b457cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

