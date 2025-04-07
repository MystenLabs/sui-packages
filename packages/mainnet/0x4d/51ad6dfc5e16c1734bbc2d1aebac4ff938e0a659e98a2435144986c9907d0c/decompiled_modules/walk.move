module 0x4d51ad6dfc5e16c1734bbc2d1aebac4ff938e0a659e98a2435144986c9907d0c::walk {
    struct WALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALK>(arg0, 9, b"Walk", b"eric", b"eric on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f8e5fde135f2c15ba12437c451d2d1deblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

