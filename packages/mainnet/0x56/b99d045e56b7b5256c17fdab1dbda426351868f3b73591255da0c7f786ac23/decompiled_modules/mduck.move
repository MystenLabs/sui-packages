module 0x56b99d045e56b7b5256c17fdab1dbda426351868f3b73591255da0c7f786ac23::mduck {
    struct MDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDUCK>(arg0, 6, b"MDUCK", b"Mr.Duck", b"Mr.Duck($MDUCK) it just a meme coin. It create for fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755490179030.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

