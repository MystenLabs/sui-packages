module 0xbb11ff7d443ac7d711f4ebbc10771cc1f2c9069aa5f813c6984482376913770c::liushuyu6666_faucet {
    struct LIUSHUYU6666_FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LIUSHUYU6666_FAUCET>, arg1: 0x2::coin::Coin<LIUSHUYU6666_FAUCET>) {
        0x2::coin::burn<LIUSHUYU6666_FAUCET>(arg0, arg1);
    }

    fun init(arg0: LIUSHUYU6666_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIUSHUYU6666_FAUCET>(arg0, 9, b"LSYFAUCET", b"LIUSHUYU6666_FAUCET", b"faucet from liushuyu6666", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/civilization/images/f/ff/Gilgamesh_%28Civ6%29.png/revision/latest?cb=20200930124313")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIUSHUYU6666_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LIUSHUYU6666_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIUSHUYU6666_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LIUSHUYU6666_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

