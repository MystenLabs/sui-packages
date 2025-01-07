module 0x2dc21c7bffd0b60f9fc04b808263cac3c2df699a8ad0cc2a7d74fb6e529d401f::lgcoin_two {
    struct LGCOIN_TWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGCOIN_TWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGCOIN_TWO>(arg0, 9, b"LGCOIN", b"Lugon Token", b"Testing purpose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://lh3.googleusercontent.com/a/AGNmyxaeqchayXhIdJi6kmrmLcczFIuynxPsqST_r7Jw=s192-c-rg-br100"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGCOIN_TWO>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LGCOIN_TWO>>(v0);
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<LGCOIN_TWO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LGCOIN_TWO>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

