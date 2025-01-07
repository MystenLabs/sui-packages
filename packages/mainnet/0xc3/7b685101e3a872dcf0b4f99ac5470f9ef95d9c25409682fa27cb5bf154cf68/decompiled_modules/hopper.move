module 0xc37b685101e3a872dcf0b4f99ac5470f9ef95d9c25409682fa27cb5bf154cf68::hopper {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPER>(arg0, 6, b"Hopper", b"Hopper the Rabbit", b"Hopper the rabbit is a well-known community token on SUI, founded by doxed SUI OGs, those have been with SUI since the very early day. The project combines the fun culture of meme with top-tier art, strong community that stick together, with the long", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734540690439.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

