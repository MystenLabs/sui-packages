module 0xd4cee65e5f7f98aba640a99810ca7104404c4056c7447397ce2ae77c5adb99a::POKE {
    struct POKE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<POKE>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0x850e5c9080bf47e912f2644092f3b8e90419f282fe4a74e4e3ee78061056c745 || 0x2::tx_context::sender(arg2) == @0x850e5c9080bf47e912f2644092f3b8e90419f282fe4a74e4e3ee78061056c745, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<POKE>>(arg0, arg1);
    }

    fun init(arg0: POKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE>(arg0, 9, b"POKE", b"PokeVerse", x"506f6b6556657273652069732074686520666972737420646563656e7472616c697a656420506f6bc3a96d6f6e2d7374796c65206d656d657665727365206275696c74206f6e207468652053554920626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tan-hidden-shark-534.mypinata.cloud/ipfs/bafkreiahhwfzsb2qrs3rukv7vy7g6ywc6u76nmvbpysrd7v2d76bd4cct4")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<POKE>>(0x2::coin::mint<POKE>(&mut v2, 1000000000000000000, arg1), @0x850e5c9080bf47e912f2644092f3b8e90419f282fe4a74e4e3ee78061056c745);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POKE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

