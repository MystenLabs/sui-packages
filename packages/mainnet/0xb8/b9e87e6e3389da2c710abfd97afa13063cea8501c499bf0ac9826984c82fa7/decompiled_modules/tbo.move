module 0xb8b9e87e6e3389da2c710abfd97afa13063cea8501c499bf0ac9826984c82fa7::tbo {
    struct TBO has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TBO>, arg1: 0x2::coin::Coin<TBO>) {
        0x2::coin::burn<TBO>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TBO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TBO>>(0x2::coin::mint<TBO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBO>(arg0, 18, b"tbo", b"timboslice", b"timboslice token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

