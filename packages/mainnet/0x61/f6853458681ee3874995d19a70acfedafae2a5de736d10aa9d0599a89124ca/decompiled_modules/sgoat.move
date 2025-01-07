module 0x61f6853458681ee3874995d19a70acfedafae2a5de736d10aa9d0599a89124ca::sgoat {
    struct SGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOAT>(arg0, 6, b"sGOAT", b"Sonic Goat", b"$sGOAT & $PLUS          linktr.ee/sonicgoat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ZZ_9_UFRA_400x400_f3c1f5c7e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

