module 0xdc3337666417ef41687cdda5e4cfc9b5b07eb91b1452b5ebf34fc9d1234c84de::my_coin_faucet {
    struct MY_COIN_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN_FAUCET>, arg1: 0x2::coin::Coin<MY_COIN_FAUCET>) {
        0x2::coin::burn<MY_COIN_FAUCET>(arg0, arg1);
    }

    fun init(arg0: MY_COIN_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN_FAUCET>(arg0, 6, b"SRF", b"Sou1ReaPerFaucet", b"created by Sou1ReaPer, faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://krseoul.imgtbl.com/i/2024/08/07/66b2ffe52d644.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MY_COIN_FAUCET>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_COIN_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

