module 0x715921323dfe5080bc80f1fe7102b14eddc500e16805bbc88a2ee7ff4dd8ac57::dork {
    struct DORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORK>(arg0, 6, b"DORK", b"Sui Dork", b"Meet DORK, Sui Dork. The awkward hero of the Sui Network. He's clumsy, he's nerdy, and he's here to prove that even dorks can make it big. Embrace your inner Dork!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/PP_65_0a66b10b0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

