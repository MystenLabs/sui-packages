module 0x1f13cf50c25f74ee27c4e926877691e9032d45acb6fccb6036ec0413085af6d0::floxi {
    struct FLOXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOXI>(arg0, 6, b"Floxi", b"Floxi Walrus", b"Floxio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9113_64e3f6cf80.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

