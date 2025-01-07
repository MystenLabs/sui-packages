module 0x609093cf763a81e6e9aa3fc2c7805b88ac2649074e4da714b660fbdefe6f53ad::fumo {
    struct FUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUMO>(arg0, 6, b"FUMO", b"FUCK THE MOON", b"Moon Revolution! #FUMO leads the lunar rebellion and gives the middle finger to all cosmic orders. This token is for everyone who wants to laugh a little at the whims of space and add a little madness to their life. Join the lunar resistance and let's show the Moon who's boss!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo2_8a4105b0ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

