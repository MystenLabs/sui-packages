module 0x8ab3252aef227213bd82f1e68eb581869dafbfd1405bc46a09136ca968790852::blu {
    struct BLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLU>(arg0, 9, b"BLU", b"blu", b"its blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/8f2e002d-a119-4493-b44d-713ce70d0a5d.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

