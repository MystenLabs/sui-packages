module 0x86b22b1322ada6ae30b9247d575fead5b845b456e25c9eec856c1c6c84c68ea::vampire {
    struct VAMPIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAMPIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAMPIRE>(arg0, 6, b"VAMPIRE", b"Sui Vampire", b"Meet $VAMPIRE The Sui Vampire. With $VAMPIRE, were creating a community of Sui nightwalkers who are ready to dominate the scene.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_73_c3a20a4147.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAMPIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAMPIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

