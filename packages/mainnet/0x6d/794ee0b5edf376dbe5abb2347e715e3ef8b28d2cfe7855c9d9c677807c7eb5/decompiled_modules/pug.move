module 0x6d794ee0b5edf376dbe5abb2347e715e3ef8b28d2cfe7855c9d9c677807c7eb5::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 6, b"PUG", b"PUG on SUI", b"Say hello to PUG, the most adorable and community-driven memecoin built on the Sui blockchain! Inspired by the playful and loyal nature of pugs, this token is all about fun, cuteness, and the spirit of togetherness. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735989926486.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

