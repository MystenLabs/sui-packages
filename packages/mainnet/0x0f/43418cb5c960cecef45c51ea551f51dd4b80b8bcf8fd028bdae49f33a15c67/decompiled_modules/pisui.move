module 0xf43418cb5c960cecef45c51ea551f51dd4b80b8bcf8fd028bdae49f33a15c67::pisui {
    struct PISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISUI>(arg0, 6, b"PISUI", b"PISUI PIPLUP in SUI", b"$PISUI is the cutest water type Pokemon inspired by Ash' PIPLUP. His joyful and cheerful characteristics will splash you some SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiayo27rzrymieibhsrbmephz36tbt6usnvmaivspntzrjdbbiiqa4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PISUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

