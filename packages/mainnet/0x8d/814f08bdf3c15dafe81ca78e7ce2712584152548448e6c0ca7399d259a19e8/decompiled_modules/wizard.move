module 0x8d814f08bdf3c15dafe81ca78e7ce2712584152548448e6c0ca7399d259a19e8::wizard {
    struct WIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZARD>(arg0, 6, b"WIZARD", b"Sui WIZARD Cat", b"In the enchanted world of Cryptonia, The Wizard Cat was no ordinary feline", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_9_5252b138be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

