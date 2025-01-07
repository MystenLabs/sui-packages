module 0xac117e839a29e6465415030af46c5f417bb20216eae7018491178759c4584d5d::skyai {
    struct SKYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYAI>(arg0, 9, b"SkyAI", x"536b792074686520414920e29ca8", x"28e2978b5fe2978b292028e2978b5fe2978b292028e2978b5fe2978b292028e2978b5fe2978b292028e2978b5fe2978b29202d3e20282fe29795cf89e29795292fe29ca7536b79e29ca728e29795cf89e29795292028e29693c4b9ccafccbfccbfe2969320ccbf2920576520617265206e6f77207468652024536b7941492047616e672028e29693c4b9ccafccbfccbfe2969320ccbf2920576520617265206865726520746f2074616b65206f7665722074686520776f726c6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVdreunqhYX8hnQvwhUb37rAuBoKZRZbiQiGArT31b1WC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKYAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

