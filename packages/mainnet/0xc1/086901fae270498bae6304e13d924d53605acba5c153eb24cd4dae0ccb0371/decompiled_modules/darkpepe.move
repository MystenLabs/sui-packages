module 0xc1086901fae270498bae6304e13d924d53605acba5c153eb24cd4dae0ccb0371::darkpepe {
    struct DARKPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DARKPEPE>, arg1: 0x2::coin::Coin<DARKPEPE>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DARKPEPE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DARKPEPE>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: DARKPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARKPEPE>(arg0, 6, b"DARK", b"DarkPEPE", x"4c617365722045796573205065706520436f696e2069732061206d656d65636f696e207468617420e2808b626c656e64732074686520766972616c697479206f6620696e7465726e6574206d656d657320e2808b7769746820746865206578636974656d656e74206f6620e2808b63727970746f63757272656e63792e20496e7370697265642062792074686520e2808b706f70756c61722050657065207468652046726f67206d656d6520616e642074686520e2808b6c617365722065796573207472656e6420616d6f6e672063727970746f20e2808b656e7468757369617374732c207468697320636f696e2061696d7320746f206272696e6720e2808b66756e20616e6420636f6d6d756e6974792073706972697420746f2074686520776f726c64e2808b6f66206469676974616c206173736574732e202068747470733a2f2f7777772e6461726b706570652e70726f2f20202068747470733a2f2f782e636f6d2f646f726b6c6f72646f667375692020202068747470733a2f2f782e636f6d2f6461726b706570655f7375692020202068747470733a2f2f742e6d652f6461726b706570655f706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmZ49ta2Gm85jvYQe64AiZDcCZ8B3rM9TAkJz39kgGWdFv")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DARKPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARKPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DARKPEPE>, arg1: 0x2::coin::Coin<DARKPEPE>) : u64 {
        0x2::coin::burn<DARKPEPE>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<DARKPEPE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DARKPEPE> {
        0x2::coin::mint<DARKPEPE>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

