module 0x4657d8688c26214f21a1b63b6a803eaaa49bf121ecff1c8788affcc184870264::smurfsuicat {
    struct SMURFSUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFSUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFSUICAT>(arg0, 6, b"SMURFSUICAT", b"SMURF CAT SUI", b"he is real.  $SMURF $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_174703843_001211de71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFSUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFSUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

