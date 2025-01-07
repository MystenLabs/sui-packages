module 0x9c57994438168e97d715f3d15a3335f7eea3f6b6bbfb3a1c1c90f397de2fe2f5::fu {
    struct FU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FU>, arg1: 0x2::coin::Coin<FU>) {
        0x2::coin::burn<FU>(arg0, arg1);
    }

    fun init(arg0: FU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FU>(arg0, 9, b"Fu", b"Fu", x"546865204368696e657365206368617261637465722046752028e7a68f29206d65616e732068617070696e6573732c20626c657373696e672c20616e6420676f6f6420666f7274756e652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/F2xBLb6jj39LJ5rg6wh8VaTq9CLEvDqLFL9gxmEapump.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FU>>(v1);
        0x2::coin::mint_and_transfer<FU>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FU>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

