module 0xeac8022d90966011f353d979881f0a160269b86c525f6c21c95fabf3e58a0db1::bemo {
    struct BEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEMO>(arg0, 6, b"BEMO", b"BEMO SUI", x"4042656d6f67656d0a4d454d45204d415849202f202044594f52202f204e4641202f20446567656e206f66203130303078206d656d6573202d204164766973696e67202b204d61726b6574696e67202d20444d203420436f6c6c61627320262050726f6d6f732e2024535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/18_bcf3ae54ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

