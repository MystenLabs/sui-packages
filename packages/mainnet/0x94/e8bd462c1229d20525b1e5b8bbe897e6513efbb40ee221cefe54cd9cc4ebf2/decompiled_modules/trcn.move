module 0x94e8bd462c1229d20525b1e5b8bbe897e6513efbb40ee221cefe54cd9cc4ebf2::trcn {
    struct TRCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRCN>(arg0, 9, b"TRCN", b"TRUMPCOIN", b"Trumpcoin to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3bf06479-b8bf-4345-90cd-5b9c9cfae037.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

