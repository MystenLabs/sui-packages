module 0x4f0cecda6f6d76cb465819ef6f2eb856a0cc4b43590209e9e42c36ae92d43e59::matteosui {
    struct MATTEOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATTEOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATTEOSUI>(arg0, 6, b"MatteoSUI", b"Matteo", x"537569204e6574776f726b2077696c6c20626520616d6f6e67207468652073706f6e736f7273206174200a407265616c446f6e616c645472756d700a20696e61756775726174696f6e206f6e204a616e7561727920323074682121212121212120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9q_L_Jwm_FU_400x400_255f688076.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATTEOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATTEOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

