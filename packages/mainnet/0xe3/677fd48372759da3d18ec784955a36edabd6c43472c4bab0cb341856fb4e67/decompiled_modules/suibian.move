module 0xe3677fd48372759da3d18ec784955a36edabd6c43472c4bab0cb341856fb4e67::suibian {
    struct SUIBIAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBIAN>, arg1: 0x2::coin::Coin<SUIBIAN>) {
        0x2::coin::burn<SUIBIAN>(arg0, arg1);
    }

    fun init(arg0: SUIBIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIAN>(arg0, 2, b"SUIBIAN", b"SUIBIAN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.328888.xyz/2023/05/04/iPKaZX.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBIAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBIAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBIAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

