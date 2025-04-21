module 0xad2da353efb218aaf34cab2e92d5f7684dbb73d5db0b95098203bdff0c48967d::yoo {
    struct YOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOO>(arg0, 6, b"YOO", b"yoopy", b"wassap yoppy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_65d21b12e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

