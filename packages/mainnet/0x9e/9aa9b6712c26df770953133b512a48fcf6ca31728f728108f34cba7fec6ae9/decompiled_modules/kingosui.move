module 0x9e9aa9b6712c26df770953133b512a48fcf6ca31728f728108f34cba7fec6ae9::kingosui {
    struct KINGOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGOSUI>(arg0, 6, b"KINGOSUI", b"King sui ", b"The meme coin that's so dope, it'll make you wanna woof woof all the way to 2025!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735498400112.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KINGOSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGOSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

