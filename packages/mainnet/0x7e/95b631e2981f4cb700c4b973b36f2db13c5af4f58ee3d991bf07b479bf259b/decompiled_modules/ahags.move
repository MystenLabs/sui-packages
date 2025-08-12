module 0x7e95b631e2981f4cb700c4b973b36f2db13c5af4f58ee3d991bf07b479bf259b::ahags {
    struct AHAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHAGS>(arg0, 6, b"AHAGS", b"asada", b"asdddaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieoitdsf2zjqliv2h4d6adecj4tyjmuyhotqwxeikqyhfvc6s5ole")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHAGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AHAGS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

