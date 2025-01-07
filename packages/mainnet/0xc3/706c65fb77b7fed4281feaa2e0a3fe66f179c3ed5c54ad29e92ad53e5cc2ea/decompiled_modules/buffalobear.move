module 0xc3706c65fb77b7fed4281feaa2e0a3fe66f179c3ed5c54ad29e92ad53e5cc2ea::buffalobear {
    struct BUFFALOBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFFALOBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFFALOBEAR>(arg0, 6, b"BUFFALOBEAR", b"SuiBufaloBear", b"Buffalo Bear On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Benji_13e55a62a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFFALOBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFFALOBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

