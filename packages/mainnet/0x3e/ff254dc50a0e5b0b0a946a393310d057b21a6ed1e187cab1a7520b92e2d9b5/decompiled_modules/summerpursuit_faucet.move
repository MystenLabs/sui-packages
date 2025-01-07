module 0x3eff254dc50a0e5b0b0a946a393310d057b21a6ed1e187cab1a7520b92e2d9b5::summerpursuit_faucet {
    struct SUMMERPURSUIT_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUMMERPURSUIT_FAUCET>, arg1: 0x2::coin::Coin<SUMMERPURSUIT_FAUCET>) {
        0x2::coin::burn<SUMMERPURSUIT_FAUCET>(arg0, arg1);
    }

    fun init(arg0: SUMMERPURSUIT_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMMERPURSUIT_FAUCET>(arg0, 6, b"BRF", b"summerpursuitFaucet", b"summerpursuit facet is so cool", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUMMERPURSUIT_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUMMERPURSUIT_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUMMERPURSUIT_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUMMERPURSUIT_FAUCET>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint_to_two_addresses(arg0: &mut 0x2::coin::TreasuryCap<SUMMERPURSUIT_FAUCET>, arg1: u64, arg2: address, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUMMERPURSUIT_FAUCET>(arg0, arg1, arg2, arg5);
        0x2::coin::mint_and_transfer<SUMMERPURSUIT_FAUCET>(arg0, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

