module 0xbf5961731bb47fd2acb29a00302e4d83a375cf076abbd479dd773e9621c40d73::caticorn {
    struct CATICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CATICORN>(arg0, 6, b"CATICORN", b"Cat Unicorn by SuiAI", b"Its a Cat riding a Unicorn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/unicorn_2e7ff28f15.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATICORN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATICORN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

