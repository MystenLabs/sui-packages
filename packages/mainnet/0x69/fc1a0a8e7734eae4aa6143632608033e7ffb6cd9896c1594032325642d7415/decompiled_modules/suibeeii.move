module 0x69fc1a0a8e7734eae4aa6143632608033e7ffb6cd9896c1594032325642d7415::suibeeii {
    struct SUIBEEII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEEII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEEII>(arg0, 6, b"SuiBeeii", b"Sui Bee V2", b"Funny Fatty Bee new release version ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734045306102.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBEEII>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEEII>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

