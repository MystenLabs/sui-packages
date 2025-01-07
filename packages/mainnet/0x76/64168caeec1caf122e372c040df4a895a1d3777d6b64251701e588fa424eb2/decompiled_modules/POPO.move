module 0x7664168caeec1caf122e372c040df4a895a1d3777d6b64251701e588fa424eb2::POPO {
    struct POPO has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POPO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POPO>>(0x2::coin::mint<POPO>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: POPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPO>(arg0, 9, b"POPO", b"POPO", b"Get rich in the bull... invest in the bear! $BOBO http://t.me/BOBO_Erc20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1648210051193270272/YBPG1tvJ_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

