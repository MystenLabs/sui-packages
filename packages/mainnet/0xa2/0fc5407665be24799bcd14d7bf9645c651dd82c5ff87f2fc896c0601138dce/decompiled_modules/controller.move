module 0xa20fc5407665be24799bcd14d7bf9645c651dd82c5ff87f2fc896c0601138dce::controller {
    struct CONTROLLER has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER>, arg1: 0x2::coin::Coin<CONTROLLER>) {
        0x2::coin::burn<CONTROLLER>(arg0, arg1);
    }

    fun init(arg0: CONTROLLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONTROLLER>(arg0, 9, b"ALPHA", b"ALPHA Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-lzv3PMgNMj.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CONTROLLER>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONTROLLER>>(v1);
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CONTROLLER> {
        0x2::coin::mint<CONTROLLER>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CONTROLLER>>(0x2::coin::mint<CONTROLLER>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

