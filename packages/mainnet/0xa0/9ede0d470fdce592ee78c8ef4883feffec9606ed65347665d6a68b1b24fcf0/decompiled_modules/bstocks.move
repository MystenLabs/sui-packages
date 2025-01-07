module 0xa09ede0d470fdce592ee78c8ef4883feffec9606ed65347665d6a68b1b24fcf0::bstocks {
    struct BSTOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSTOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSTOCKS>(arg0, 6, b"BSTOCKS", b"Book of Stocks on Sui", b"$BSTOCKS  The memecoin merging crypto fun with stock market vibes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_20_56_51_b98adcadf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSTOCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSTOCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

