module 0x3fde0d161db65f10bdcb6cc2bbf5d460af2c39b94b5c01a9664d3cffe1a256de::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 9, b"PUMP", b"Rapidgang", b"RapidGag is a fun, community-driven token that merges the thrill of rafting with meme humor. Like rapids, every transaction is fast and full of laughs. Perfect for adventurers and meme enthusiasts, RapidGag makes every exchange an exciting, humorous ride!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d134f3c-0e1b-418f-a9c1-ac1542620a4c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

