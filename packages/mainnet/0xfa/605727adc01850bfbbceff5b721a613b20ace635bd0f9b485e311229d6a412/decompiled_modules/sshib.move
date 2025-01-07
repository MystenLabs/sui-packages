module 0xfa605727adc01850bfbbceff5b721a613b20ace635bd0f9b485e311229d6a412::sshib {
    struct SSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHIB>(arg0, 6, b"SSHIB", b"SShib On SUI", b"Most Bullish CTO of all time.Thanks, Founders. We will take it from here! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_Cl90_UY_4_400x400_782f25b513.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

