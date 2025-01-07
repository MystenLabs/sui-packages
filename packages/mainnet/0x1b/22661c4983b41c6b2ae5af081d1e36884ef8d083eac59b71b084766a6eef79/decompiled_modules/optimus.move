module 0x1b22661c4983b41c6b2ae5af081d1e36884ef8d083eac59b71b084766a6eef79::optimus {
    struct OPTIMUS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OPTIMUS>, arg1: 0x2::coin::Coin<OPTIMUS>) {
        0x2::coin::burn<OPTIMUS>(arg0, arg1);
    }

    fun init(arg0: OPTIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPTIMUS>(arg0, 9, b"Optimus", b"OPTIMUS", b"Move over, Bitcoin. Step aside, Dogecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/31n9Do8vj8Lu8EFSPGo5xBK8AAcycqTYKmNSM4bQpump.png?size=lg&key=70ef77")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPTIMUS>>(v1);
        0x2::coin::mint_and_transfer<OPTIMUS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OPTIMUS>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OPTIMUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OPTIMUS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

