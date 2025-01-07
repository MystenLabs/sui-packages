module 0x13853e9e517b437562485effc8bdfb5db146842470b6bf15a0752ac9c60f0136::church {
    struct CHURCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHURCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHURCH>(arg0, 6, b"CHURCH", b"ATH", x"4154482e434855524348207374616e6473206669726d20616761696e7374205472616e7368756d616e69736d2c207465616368696e672062656c69657665727320746f2072656a656374207468652069646f6c61747279206f6620746563686e6f6c6f677920616e6420747275737420696e20476f64e280997320706572666563742064657369676e2e205468652043687572636820676f7665726e616e6365206973206f6e2d636861696e207769746820696e7465677261746564206f7065726174696f6e616c20746563686e6f6c6f676965732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732592490026.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHURCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHURCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

