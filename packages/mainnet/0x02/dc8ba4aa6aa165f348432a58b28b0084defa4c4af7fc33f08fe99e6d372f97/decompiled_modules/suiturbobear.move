module 0x2dc8ba4aa6aa165f348432a58b28b0084defa4c4af7fc33f08fe99e6d372f97::suiturbobear {
    struct SUITURBOBEAR has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITURBOBEAR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITURBOBEAR>>(0x2::coin::mint<SUITURBOBEAR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUITURBOBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITURBOBEAR>(arg0, 6, b"Sui Turbo Bear", b"TurboBear", b"Sui Turbo Bear Meme Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITURBOBEAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITURBOBEAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

