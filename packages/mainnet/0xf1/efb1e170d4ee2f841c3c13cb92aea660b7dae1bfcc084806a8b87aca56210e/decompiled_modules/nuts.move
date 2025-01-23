module 0xf1efb1e170d4ee2f841c3c13cb92aea660b7dae1bfcc084806a8b87aca56210e::nuts {
    struct NUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTS>(arg0, 6, b"NUTS", b"NUTS THE SQUIRREL ", b"Why save acorns when you can save SUI? This squirrel's portfolio is looking nuts! From forest floors to financial freedom, this squirrel proves that even the smallest investors can make the biggest moves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737595215808.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

