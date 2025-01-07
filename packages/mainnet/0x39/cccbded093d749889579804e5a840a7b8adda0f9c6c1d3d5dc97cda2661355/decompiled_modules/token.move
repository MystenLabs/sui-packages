module 0x39cccbded093d749889579804e5a840a7b8adda0f9c6c1d3d5dc97cda2661355::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"BIT", b"BIT", b"This is token test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://png.pngtree.com/png-clipart/20201123/ourmid/pngtree-vector-coins-icon-dollar-gold-coin-png-image_2462733.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

