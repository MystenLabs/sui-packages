module 0x93201ed88e97437e2359e7c32adf3995620badf74c6f36d8beb1031f0171632d::magma {
    struct MAGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGMA>(arg0, 0, b"MAGMA", b"MAGMA", b"Fake MAGMA for Sui deposit parser testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGMA>>(v1);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<MAGMA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGMA>>(0x2::coin::mint<MAGMA>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

