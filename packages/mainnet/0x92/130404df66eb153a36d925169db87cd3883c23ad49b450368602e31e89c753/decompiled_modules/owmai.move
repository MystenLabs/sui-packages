module 0x92130404df66eb153a36d925169db87cd3883c23ad49b450368602e31e89c753::owmai {
    struct OWMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OWMAI>(arg0, 6, b"OWMAI", b"On our way to Mars AI by SuiAI", b"Join our mission to Mars and beyond!  Reaching new worlds with  the help of AI is imminent. Space exploration will guarantee the future of humanity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image000003_ae298af47e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OWMAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWMAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

