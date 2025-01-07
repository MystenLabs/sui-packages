module 0x399b887490891b113776cc7d02c58902f6e9ce928a5f71390f8bdfb37e76d828::rico {
    struct RICO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICO>(arg0, 6, b"RICO", b"RICO on Sui", b"$RICO isnt just a coinits a mindset for traders who dare to stand out and take bold steps toward success!.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C4_Rr_Rz4_400x400_7fc067e3b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICO>>(v1);
    }

    // decompiled from Move bytecode v6
}

