module 0xacff0b5c96eed46b5e3bfceb0609d9e57efe603824636bd7cd335dcd18f27abd::msca {
    struct MSCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSCA>(arg0, 6, b"mSCA", b"ScallopMeme", b"The Next Generation Money Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_Sbx_syqh_7f92a55b0d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

