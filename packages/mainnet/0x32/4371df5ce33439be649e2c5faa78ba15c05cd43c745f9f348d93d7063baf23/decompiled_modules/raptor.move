module 0x324371df5ce33439be649e2c5faa78ba15c05cd43c745f9f348d93d7063baf23::raptor {
    struct RAPTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAPTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAPTOR>(arg0, 6, b"RAPTOR", b"Philosoraptor", b"The blockchain's answer to the universe's big questions, wrapped in a meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731575118047.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAPTOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAPTOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

