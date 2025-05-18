module 0xd91567d5ed84d2c9bd626b94c0bbf8b7bae083437146bf7afc3e7993890dcdc4::POKE {
    struct POKE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<POKE>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0xda939817dec72173d06bd7726dc6a21a7b7496e66b285988062ee8d96fd85321 || 0x2::tx_context::sender(arg2) == @0xda939817dec72173d06bd7726dc6a21a7b7496e66b285988062ee8d96fd85321, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<POKE>>(arg0, arg1);
    }

    fun init(arg0: POKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE>(arg0, 9, b"POKE", b"PokeVerse", x"506f6b6556657273652069732074686520666972737420646563656e7472616c697a656420506f6bc3a96d6f6e2d7374796c65206d656d657665727365206275696c74206f6e207468652053554920626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tan-hidden-shark-534.mypinata.cloud/ipfs/bafkreiahhwfzsb2qrs3rukv7vy7g6ywc6u76nmvbpysrd7v2d76bd4cct4")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<POKE>>(0x2::coin::mint<POKE>(&mut v2, 1000000000000000000, arg1), @0xda939817dec72173d06bd7726dc6a21a7b7496e66b285988062ee8d96fd85321);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POKE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

