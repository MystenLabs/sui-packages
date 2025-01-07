module 0x4a71856fb3f1fa00686efa35b9d17ef59b76b6ef127f3bdb68fe92f87f8f4761::ticker {
    struct TICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKER>(arg0, 6, b"TICKER", b"$Ticker The Ticker", b"Only The Ticker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241006_WA_0006_e3f883e65e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

