module 0xabf5f6c057364e5d5b695dfb913c5010b13b84185f29737b82c87c830584a992::bigdonald {
    struct BIGDONALD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BIGDONALD>, arg1: 0x2::coin::Coin<BIGDONALD>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BIGDONALD>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BIGDONALD>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BIGDONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGDONALD>(arg0, 6, b"DONALD", b"Big Donald", x"466f7267657420426974636f696e2c206d6f7665206f76657220535549e28094746865726527732061206e657720706c6179657220696e207468652063727970746f206172656e613a2024444f4e414c4420202068747470733a2f2f7777772e626967646f6e616c642e6c6976652f20202068747470733a2f2f782e636f6d2f626967646f6e616c647375692020202068747470733a2f2f742e6d652f626967646f6e616c645f706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmbnVi9YRG1zfjXa4ES9SU8rqxueK5XAnvhZUnzANtcvWb")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGDONALD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGDONALD>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BIGDONALD>, arg1: 0x2::coin::Coin<BIGDONALD>) : u64 {
        0x2::coin::burn<BIGDONALD>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BIGDONALD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BIGDONALD> {
        0x2::coin::mint<BIGDONALD>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

