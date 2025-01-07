module 0x7f64b960ded15cfea042bee65cbd34e54ab3aba674715112ec6696d8e7d0ec70::pnutsui {
    struct PNUTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTSUI>(arg0, 6, b"PNUTSUI", b"Peanut Sui", b"Beloved Peanut the Squirrel was taken away from his home by NYSDEC and euthanized. As a symbol of the injustice of life, peanuts will be remembered forever. R.I.P Peanut the Squirrel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731762561487.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUTSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

