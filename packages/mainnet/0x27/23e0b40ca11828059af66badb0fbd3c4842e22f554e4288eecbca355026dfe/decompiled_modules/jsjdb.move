module 0x2723e0b40ca11828059af66badb0fbd3c4842e22f554e4288eecbca355026dfe::jsjdb {
    struct JSJDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSJDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSJDB>(arg0, 6, b"Jsjdb", b"Jvcc", b"Hhhhbcfhjnhg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreignetg73k46gavldl2twrtc76kk7ezj2cahyycuwapbukcxbju4pm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSJDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JSJDB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

