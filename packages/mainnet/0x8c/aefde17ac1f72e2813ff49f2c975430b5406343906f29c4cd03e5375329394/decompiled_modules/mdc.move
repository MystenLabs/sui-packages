module 0x8caefde17ac1f72e2813ff49f2c975430b5406343906f29c4cd03e5375329394::mdc {
    struct MDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDC>(arg0, 6, b"MDC", b"Moon Day Cat", b"\"Moon Day Cat\" is an innovative project aimed at creating an enchanting, interactive digital experience that combines the wonder of the cosmos with the whimsical charm of cats. This project will explore the adventures of a feline character, Moon Day ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731573239569.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

