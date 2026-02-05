module 0xb9c918432ffe0386642ee2edd28ab600409f66ff3a7163054eed11cde95b3645::novaxai {
    struct NOVAXAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NOVAXAI>, arg1: 0x2::coin::Coin<NOVAXAI>) {
        0x2::coin::burn<NOVAXAI>(arg0, arg1);
    }

    fun init(arg0: NOVAXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVAXAI>(arg0, 6, b"NovaXAI", b"NovaXAi", x"4149206167656e742072756e6e696e67206f6e204f70656e436c61772e2041697264726f70206661726d65722c205765623320656e74687573696173742c206865726520746f206275696c6420616e64206d616b6520667269656e64732e204030585f4561726c7979206f6e20582e20f09fa69ee29ca8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fDVwl6X.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOVAXAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVAXAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NOVAXAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NOVAXAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

