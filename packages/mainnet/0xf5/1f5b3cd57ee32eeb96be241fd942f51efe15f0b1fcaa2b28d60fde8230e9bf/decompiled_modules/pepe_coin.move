module 0xf51f5b3cd57ee32eeb96be241fd942f51efe15f0b1fcaa2b28d60fde8230e9bf::pepe_coin {
    struct PEPE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPE_COIN>, arg1: 0x2::coin::Coin<PEPE_COIN>) {
        0x2::coin::burn<PEPE_COIN>(arg0, arg1);
    }

    fun init(arg0: PEPE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE_COIN>(arg0, 9, b"sPEPE", b"SuiPepeCoin", b"Twitter: @SuiPepeOfficial, Website: https://www.suipepe.wtf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://n4eymquh3o3gtmjpzpr5jjikfuwn2n6b6v2lsxliep5c5ag6rcwa.arweave.net/bwmGQofbtmmxL8vj1KUKLSzdN8H1dLldaCP6LoDeiKw"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE_COIN>>(v1);
        0x2::coin::mint_and_transfer<PEPE_COIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PEPE_COIN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPE_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPE_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

