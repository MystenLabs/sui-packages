module 0xb4de888081b2ad22da86e42d99a204df32345681f5aae9d4e2c23737ce9055c7::syz {
    struct SYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYZ>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"SYZ", b"SYZYGY", b"SyzygyStrategy Vault Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2014998280455749633/MtArfuQX_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

