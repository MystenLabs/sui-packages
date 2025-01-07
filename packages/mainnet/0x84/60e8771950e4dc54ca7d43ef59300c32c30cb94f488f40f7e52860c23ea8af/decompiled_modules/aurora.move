module 0x8460e8771950e4dc54ca7d43ef59300c32c30cb94f488f40f7e52860c23ea8af::aurora {
    struct AURORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURORA>(arg0, 6, b"AURORA", b"Aurora", b"AURORA - QIFN-1GBF1`=0FNQF1`B=F=0``21121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/888888_038172c501.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AURORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

