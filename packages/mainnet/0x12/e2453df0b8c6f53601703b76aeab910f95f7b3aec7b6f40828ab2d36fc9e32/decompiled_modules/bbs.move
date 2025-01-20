module 0x12e2453df0b8c6f53601703b76aeab910f95f7b3aec7b6f40828ab2d36fc9e32::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBS>(arg0, 9, b"BBS", b"Baby Shark", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/65671d0fefdce71874e5fcab96d0ad67blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

