module 0x2bb7870688a5b461360299d8d3181986742b0442f18d7c69e9b2595a256f554d::ducat {
    struct DUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCAT>(arg0, 6, b"DUCAT", b"dubcattoken", b"$DUBCAT- The Cat that drops beats on the blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_Vs_Gdj3i_400x400_4f7446c56e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

