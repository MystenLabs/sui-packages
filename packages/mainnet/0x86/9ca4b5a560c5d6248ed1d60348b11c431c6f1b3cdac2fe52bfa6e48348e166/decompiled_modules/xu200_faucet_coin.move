module 0x869ca4b5a560c5d6248ed1d60348b11c431c6f1b3cdac2fe52bfa6e48348e166::xu200_faucet_coin {
    struct XU200_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<XU200_FAUCET_COIN>, arg1: 0x2::coin::Coin<XU200_FAUCET_COIN>) {
        0x2::coin::burn<XU200_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: XU200_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XU200_FAUCET_COIN>(arg0, 9, b"XU200_FAUCET", b"XU200_FAUCET", b"xu200's first faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/87858460")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XU200_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<XU200_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XU200_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XU200_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

