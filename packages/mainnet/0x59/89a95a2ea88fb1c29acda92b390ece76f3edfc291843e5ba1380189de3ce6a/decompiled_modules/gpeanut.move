module 0x5989a95a2ea88fb1c29acda92b390ece76f3edfc291843e5ba1380189de3ce6a::gpeanut {
    struct GPEANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPEANUT>(arg0, 6, b"GPEANUT", b"Great Peanut", b"We love BTC, bring Peanut in sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732143254757.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GPEANUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPEANUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

