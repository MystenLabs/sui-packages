module 0xd2450acc700e0ce4638f66e80598e440288ad9f09d35dc8dd1f592922760ebbd::veristu_faucet_coin {
    struct VERISTU_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<VERISTU_FAUCET_COIN>, arg1: 0x2::coin::Coin<VERISTU_FAUCET_COIN>) {
        0x2::coin::burn<VERISTU_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: VERISTU_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VERISTU_FAUCET_COIN>(arg0, 9, b"VERISTU_FAUCET", b"VERISTU_FAUCET", b"faucet coin defined by veristu, everyone can access and mutate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169317650")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VERISTU_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VERISTU_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VERISTU_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<VERISTU_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

