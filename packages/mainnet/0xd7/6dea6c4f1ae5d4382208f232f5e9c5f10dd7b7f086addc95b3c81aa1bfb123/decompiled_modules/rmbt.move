module 0xd76dea6c4f1ae5d4382208f232f5e9c5f10dd7b7f086addc95b3c81aa1bfb123::rmbt {
    struct RMBT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RMBT>, arg1: 0x2::coin::Coin<RMBT>) {
        0x2::coin::burn<RMBT>(arg0, arg1);
    }

    fun init(arg0: RMBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMBT>(arg0, 9, b"RMBT", b"RMBT", b"This is RMBT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/wcoo17/status/1997963040676049372/photo/1")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RMBT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RMBT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RMBT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

