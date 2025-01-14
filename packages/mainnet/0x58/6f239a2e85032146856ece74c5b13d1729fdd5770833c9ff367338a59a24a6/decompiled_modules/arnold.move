module 0x586f239a2e85032146856ece74c5b13d1729fdd5770833c9ff367338a59a24a6::arnold {
    struct ARNOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARNOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ARNOLD>(arg0, 6, b"ARNOLD", b"MEET ARNOLD ON SUI by SuiAI", b"Hey! It's Arnold. Just hanging out here! Having 3.86 M subscribers on YouTube, now on SUI - Automated by AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_b224b3996b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARNOLD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARNOLD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

