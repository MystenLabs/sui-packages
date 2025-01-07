module 0x90718abb574e574cfe5231fe1a1c85885991e0cb925d84977b03a91dd232ec26::catlong {
    struct CATLONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATLONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATLONG>(arg0, 6, b"CATLONG", b"catlong on sui", b"CATLOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000126965_9e073ed038.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATLONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATLONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

