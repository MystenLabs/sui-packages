module 0x1d1154b21f38df2f8a8769415e129e2aeac7af1aecc77c95c80024bc151ed26f::ops {
    struct OPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPS>(arg0, 6, b"OPS", b"One Purple Shoelace", b" Im late on rent, so Im trading my way up from one single purple shoelace to a housejust like One Red Paperclip. This is a tribute to the ultimate barter challenge. Follow the journey, trade up, and lets see how far one shoelace can go.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007365_d53361ed81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

