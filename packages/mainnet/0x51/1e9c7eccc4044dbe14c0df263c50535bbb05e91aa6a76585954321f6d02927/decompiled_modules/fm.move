module 0x511e9c7eccc4044dbe14c0df263c50535bbb05e91aa6a76585954321f6d02927::fm {
    struct FM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FM>(arg0, 9, b"FM", b"FunnyMoney", x"4561726e206d6f6e657920f09f92b0207768696c65206265696e67206861707079", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ca0db04-d7bc-4b86-a007-95bae034e8fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FM>>(v1);
    }

    // decompiled from Move bytecode v6
}

