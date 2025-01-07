module 0x92f767ee2fa5f7f7d3a7058712591f6d9d13ba2aa3e978fcff0fc07c2a91dabc::rats {
    struct RATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATS>(arg0, 6, b"RATS", b"SUIRATS", b"SUIRATS is a captivating memecoin making waves in the crypto world. With a vibrant community and growth potential, it's accessible and relatable. Join the SUIRAT revolution and be part of something special.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_13_54_56_eac1ed9a4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

