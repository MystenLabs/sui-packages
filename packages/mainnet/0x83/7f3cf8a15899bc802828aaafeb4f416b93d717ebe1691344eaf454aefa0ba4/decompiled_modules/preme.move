module 0x837f3cf8a15899bc802828aaafeb4f416b93d717ebe1691344eaf454aefa0ba4::preme {
    struct PREME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PREME>(arg0, 6, b"PREME", b"SuiPreme", b"SuiPreme: The blue whale meme asset on the Sui network. Where the whales belong. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1775314915104.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PREME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PREME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

