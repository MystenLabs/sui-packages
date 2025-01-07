module 0x27c6ffbc7c79d3607f00aa72de66bff8d0a227a55ac45d7a9af65b77cc525f18::bone {
    struct BONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONE>(arg0, 6, b"BONE", b"BLUE BONE DOG", x"426f6e652069732061206d656d65636f696e2074686174206d616b6573206120646966666572656e636520696e2073756920426c6f636b636861696e2077697468206f70656e20736f757263652c20626f6e652077696c6c206d616b65207468652073756920636f6d6d756e69747920687970650a0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3866_1c289bc300.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

