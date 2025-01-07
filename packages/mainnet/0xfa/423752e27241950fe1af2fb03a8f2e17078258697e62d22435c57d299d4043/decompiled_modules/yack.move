module 0xfa423752e27241950fe1af2fb03a8f2e17078258697e62d22435c57d299d4043::yack {
    struct YACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: YACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YACK>(arg0, 6, b"YACK", b"Yack On Sui", b"The friendly ai yeti named $YACK, helping the world with their educational questions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241224_074044_50155c05dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

