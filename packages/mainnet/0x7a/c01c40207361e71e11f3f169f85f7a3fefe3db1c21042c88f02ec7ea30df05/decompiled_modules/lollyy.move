module 0x7ac01c40207361e71e11f3f169f85f7a3fefe3db1c21042c88f02ec7ea30df05::lollyy {
    struct LOLLYY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOLLYY>, arg1: 0x2::coin::Coin<LOLLYY>) {
        0x2::coin::burn<LOLLYY>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOLLYY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOLLYY>>(0x2::coin::mint<LOLLYY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LOLLYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLLYY>(arg0, 9, b"LOLLYY", b"LOLLYY", b"testing ", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLLYY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLLYY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

