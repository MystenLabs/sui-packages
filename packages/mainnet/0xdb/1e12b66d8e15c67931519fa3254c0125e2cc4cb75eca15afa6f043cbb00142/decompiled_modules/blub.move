module 0xdb1e12b66d8e15c67931519fa3254c0125e2cc4cb75eca15afa6f043cbb00142::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLUB>, arg1: 0x2::coin::Coin<BLUB>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<BLUB>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLUB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUB>>(0x2::coin::mint<BLUB>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<BLUB>(arg0, 9, b"BLUB", b"BLUB", x"424c554220e28094207468652063757465737420626c6f6266697368206d656d6520636f696e206f6e205375692e204a75737420766962696e2720756e64657277617465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coin-images.coingecko.com/coins/images/39356/large/Frame_38.png?1721888572")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<BLUB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BLUB>>(v0);
    }

    // decompiled from Move bytecode v6
}

