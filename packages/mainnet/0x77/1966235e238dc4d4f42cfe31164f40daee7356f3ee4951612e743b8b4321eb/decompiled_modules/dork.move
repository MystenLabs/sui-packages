module 0x771966235e238dc4d4f42cfe31164f40daee7356f3ee4951612e743b8b4321eb::dork {
    struct DORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORK>(arg0, 6, b"DORK", b"Sui Dork", b"Meet DORK, Sui Dork. The awkward hero of the Sui Network. He's clumsy, he's nerdy, and he's here to prove that even dorks can make it big. Embrace your inner Dork!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_92_1_88c64e2e70.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

