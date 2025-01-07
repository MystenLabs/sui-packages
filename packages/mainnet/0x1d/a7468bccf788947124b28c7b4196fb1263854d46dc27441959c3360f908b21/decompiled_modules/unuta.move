module 0x1da7468bccf788947124b28c7b4196fb1263854d46dc27441959c3360f908b21::unuta {
    struct UNUTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNUTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNUTA>(arg0, 6, b"UNUTA", b"United Pnut of Ameri", b"Squirrels got banks, citizens got $UPA! Join the United Pnut of America and watch your wallet grow! only on @turbos_finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730979297933.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNUTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNUTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

