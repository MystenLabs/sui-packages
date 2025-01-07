module 0xdbc1b4c84f394cfb1e9db939d32a92c7f69d386fd4c5e2f4707f7672e290289f::spidy {
    struct SPIDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIDY>(arg0, 6, b"SPIDY", b"SpidyDog Sui", b"$SPIDY harnesses the power of jumping and running, climbing to the top of the Meme Ocean and crossing the surface of the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001376_4400573f79.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

