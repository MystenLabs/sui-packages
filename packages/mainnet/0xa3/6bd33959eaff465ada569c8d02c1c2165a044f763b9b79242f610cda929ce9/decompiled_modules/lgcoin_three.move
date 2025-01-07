module 0xa36bd33959eaff465ada569c8d02c1c2165a044f763b9b79242f610cda929ce9::lgcoin_three {
    struct LGCOIN_THREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGCOIN_THREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGCOIN_THREE>(arg0, 9, b"LGCOIN", b"Lugon Token", b"Testing purpose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://lh3.googleusercontent.com/a/AGNmyxaeqchayXhIdJi6kmrmLcczFIuynxPsqST_r7Jw=s192-c-rg-br100"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGCOIN_THREE>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LGCOIN_THREE>>(v0);
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<LGCOIN_THREE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LGCOIN_THREE>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

