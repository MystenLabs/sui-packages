module 0x986b9640e7b40e3c0b2240511f5db0c2b2cede3baadf012d28a19c915be8e51f::fauetcoin {
    struct FAUETCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUETCOIN>, arg1: 0x2::coin::Coin<FAUETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<FAUETCOIN>(arg0, arg1);
    }

    fun init(arg0: FAUETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUETCOIN>(arg0, 9, b"FAUETCOIN", b"FAUETCOIN1", b"build coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUETCOIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUETCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

