module 0xe4e3d7b3a6567b90019f07092e8625ef102deaaf8a29ca465a3bf8d89471a098::SUIT {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUI BLINKY", b"BLINKY", b"3 eyes as 3 letters in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F3eye_bdfb0c505d.jpg&w=640&q=75")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

