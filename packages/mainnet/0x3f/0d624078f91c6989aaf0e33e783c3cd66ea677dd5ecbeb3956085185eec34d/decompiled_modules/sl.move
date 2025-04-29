module 0x3f0d624078f91c6989aaf0e33e783c3cd66ea677dd5ecbeb3956085185eec34d::sl {
    struct SL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SL>(arg0, 9, b"SL", b"Spongeloaf", x"53706f6e67656c6f6166206973207468652073756e2d64617a65642073746172666973682077686f20666f72676f7420776861742063727970746f206973e280a620627574207374696c6c206d61646520313030782e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/300f29f274f5a3ec26bde57868cb4f43blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

