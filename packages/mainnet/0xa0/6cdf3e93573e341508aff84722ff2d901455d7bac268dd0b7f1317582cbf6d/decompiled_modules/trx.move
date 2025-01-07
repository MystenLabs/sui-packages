module 0xa06cdf3e93573e341508aff84722ff2d901455d7bac268dd0b7f1317582cbf6d::trx {
    struct TRX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TRX>, arg1: 0x2::coin::Coin<TRX>) {
        0x2::coin::burn<TRX>(arg0, arg1);
    }

    fun init(arg0: TRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRX>(arg0, 6, b"TRX", b"Tron Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/XDcDswQ/trx.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRX>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TRX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

