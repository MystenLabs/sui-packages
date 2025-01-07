module 0x534d3bba9fcf49c9bf11538b6e04a9af96a901ea96849287e6a086590cb6179f::cct {
    struct CCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCT>(arg0, 6, b"CCT", b"COWCAT", b"A cowcat in the middle of a desert. Ready to fight with the other memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730499712837.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

