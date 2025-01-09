module 0x4d9bc88a8d045b4d2d1da79d9bf288676694e331814e6eba6c84925491b90645::blmai {
    struct BLMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLMAI>(arg0, 6, b"BLMAI", b"Black Language Model AI", x"4120636f6d6d756e69747920636c61696d6564206f776e65727368697020666f72207468697320746f6b656e206f6e204a616e20303920323032350a0a436f6d6d756e69747920436c61696d0a0a50726576696f7573204445582077617320612077616c6c657420647261696e65722e20436f6d6d756e697479206861732074616b656e206f7665722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_7c0229c464.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLMAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLMAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

