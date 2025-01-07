module 0x712ee6a60cfbbea7e418a2ee6808872fceff37883936bcca820cc93c2625cfd9::bneiro {
    struct BNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNEIRO>(arg0, 6, b"Bneiro", b"Book of Neiro", b"Book of Neiro on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOVE_PROFILE_AND_TWITTER_972c2ba91d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

