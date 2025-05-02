module 0xdeab3c1d129e60a924e4428c45c1945618a6ae00f906ba22610827edd0c5befd::idx {
    struct IDX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IDX>, arg1: 0x2::coin::Coin<IDX>) {
        0x2::coin::burn<IDX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<IDX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<IDX>>(0x2::coin::mint<IDX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: IDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDX>(arg0, 9, b"IDX", b"IDX", b"IDX WORK", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

