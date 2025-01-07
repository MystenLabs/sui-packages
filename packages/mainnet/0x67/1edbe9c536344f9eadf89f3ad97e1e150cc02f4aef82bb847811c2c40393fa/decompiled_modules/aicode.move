module 0x671edbe9c536344f9eadf89f3ad97e1e150cc02f4aef82bb847811c2c40393fa::aicode {
    struct AICODE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AICODE>, arg1: 0x2::coin::Coin<AICODE>) {
        0x2::coin::burn<AICODE>(arg0, arg1);
    }

    fun init(arg0: AICODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AICODE>(arg0, 2, b"AICODE", b"AICODE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AICODE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICODE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AICODE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AICODE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

