module 0x7197b8c8d9313deac72ee4b0f7a054ce55113b1fa4f3cea2817ae73655a07705::stepbotxiaoliai {
    struct STEPBOTXIAOLIAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<STEPBOTXIAOLIAI>, arg1: 0x2::coin::Coin<STEPBOTXIAOLIAI>) {
        0x2::coin::burn<STEPBOTXIAOLIAI>(arg0, arg1);
    }

    fun init(arg0: STEPBOTXIAOLIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEPBOTXIAOLIAI>(arg0, 6, b"stepbotxiaoliai", b"stepbotxiaoliai", b"stepbotxiaoliai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1862337361587179520/JvjxPbl__normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEPBOTXIAOLIAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEPBOTXIAOLIAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<STEPBOTXIAOLIAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STEPBOTXIAOLIAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

