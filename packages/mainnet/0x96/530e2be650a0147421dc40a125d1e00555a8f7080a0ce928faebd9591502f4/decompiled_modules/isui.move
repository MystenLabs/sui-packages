module 0x96530e2be650a0147421dc40a125d1e00555a8f7080a0ce928faebd9591502f4::isui {
    struct ISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISUI>(arg0, 6, b"ISUI", b"ICE SUI", b"Welcome to the IsuiLand ! $ISUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMAGE_2024_03_27_221623_ee52f16739.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

