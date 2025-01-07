module 0x716ac8d67b25dab1278b1ea9546665b4161752886d098dfe0b1cb54b9663864b::psuiduck {
    struct PSUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUIDUCK>(arg0, 6, b"PSUIDUCK", b"Psui Duck", b"Sui chain Meme Project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029361_199753059e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUIDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

