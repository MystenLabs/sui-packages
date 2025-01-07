module 0x55ee7efe74d41864a05e7103e1bf14dcfe86d2de7704a29ac91ee8effdaa7f78::sud {
    struct SUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUD>(arg0, 6, b"SUD", b"Sui drop", b"The next big meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000405449_8ef8f7d065.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

