module 0x3db5868711ec7e9e7bcfad83fc892ae3619f924ba8bba63890cbb84f925d15d::b_broccoli {
    struct B_BROCCOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BROCCOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BROCCOLI>(arg0, 9, b"bBROCCOLI", b"bToken BROCCOLI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BROCCOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BROCCOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

