module 0x8a3aea2394b1da14158ba58b37a3f695bebc431f6da1da6e380d55a80cb8158::l {
    struct L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L>(arg0, 6, b"L", b"Mangione ", b"The fall guy she fell for. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735025131740.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

