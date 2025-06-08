module 0xa313307b684aa22d009105954ac9bc86b611faaf5f8f3c8439543607488b50b2::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"Meowchu", x"4d656f77636875205468652053686f636b696e676c792043757465204d656d6520436174210a48616c66206361742c2068616c66206c696768746e696e672c20616c6c206d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebfz5octz7kcgnxnrhinoivsovabuk6cp3mzddlezetxzuujayv4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEOW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

