module 0xd67ac44369c7dfd3bf978d6e32af3b31a77a1edb59acbaf00c4bcbd8ebb8c113::sonkey {
    struct SONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONKEY>(arg0, 6, b"SONKEY", b"Sui Monkey", b"Meet $SONKEY The First Monkey on SUI,brother of PONKE.Sonkey holds the winning hand to become the top MEME ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_2a5da218f7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

