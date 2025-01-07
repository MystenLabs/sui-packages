module 0xd32b6654d8530916b992d2fd04735cb046b61190131b595ead9189ce167cc7::tiu {
    struct TIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TIU>(arg0, 9, b"TIU", b"TUI COIN", b"TUI COIN is a coin for the TUI project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/previews/011/947/129/original/gold-internet-icon-free-png.png")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIU>>(v2);
        0x2::coin::mint_and_transfer<TIU>(&mut v3, 100000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIU>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

