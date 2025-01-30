module 0xd19aaf07297ee3b040572778e1de9f57822b6f6655279b4dfaf08811d5456054::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAN>(arg0, 9, b"Bean", b"Killer Bean", b"I am Killer Bean, a rogue assassin coffee bean, who takes out the trash in this world, one bullet at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUthLqgLrmYu1HbmfLQLwsxuKGRjczxJf1PtkW4EobLju")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BEAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

