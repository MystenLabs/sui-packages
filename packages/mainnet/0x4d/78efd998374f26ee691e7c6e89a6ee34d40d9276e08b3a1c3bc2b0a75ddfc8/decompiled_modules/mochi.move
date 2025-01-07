module 0x4d78efd998374f26ee691e7c6e89a6ee34d40d9276e08b3a1c3bc2b0a75ddfc8::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOCHI>, arg1: 0x2::coin::Coin<MOCHI>) {
        0x2::coin::burn<MOCHI>(arg0, arg1);
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI COIN", b"MOCHI", b"Mochi will be the super-layer which cover every web3 use-cases cross-chain with friendly UX for newbies and degens! visit us at : https://mochi.gg/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/5nR96yg/mochi.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOCHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

