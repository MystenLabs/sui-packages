module 0x9086fb1fcf6cce276dcd6bd757882ae11a8a652cce26365683c2d927dfb8f29c::awagawag {
    struct AWAGAWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWAGAWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWAGAWAG>(arg0, 6, b"Awagawag", b"awag", b"jancuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/original_a2b2bbf408.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWAGAWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWAGAWAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

