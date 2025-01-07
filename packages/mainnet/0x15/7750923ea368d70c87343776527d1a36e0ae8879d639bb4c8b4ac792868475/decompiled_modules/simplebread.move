module 0x157750923ea368d70c87343776527d1a36e0ae8879d639bb4c8b4ac792868475::simplebread {
    struct SIMPLEBREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPLEBREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPLEBREAD>(arg0, 6, b"SIMPLEBREAD", b"It is simply a Bread", b"It is simply a Bread.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_6_08958f7256.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPLEBREAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMPLEBREAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

