module 0x8850050b98d909e3a0e83496ab034bd1e08a38636278d1fecd40b20ac2ec08a3::shooter {
    struct SHOOTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOOTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOOTER>(arg0, 6, b"SHOOTER", b"Official Trump Shooter Coin", b"Official Trump Shooter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_053205_810_d128f7f45c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOOTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOOTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

