module 0x320a292ed322d4427db46338fef6513746d61e141a2e4b3f3729db430b811bc9::dos {
    struct DOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOS>(arg0, 6, b"DOS", b"Doggy on Sui", b"just another doggy on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735136637500.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

