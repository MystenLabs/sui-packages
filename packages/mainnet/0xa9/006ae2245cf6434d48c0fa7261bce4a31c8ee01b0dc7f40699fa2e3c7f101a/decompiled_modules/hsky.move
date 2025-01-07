module 0xa9006ae2245cf6434d48c0fa7261bce4a31c8ee01b0dc7f40699fa2e3c7f101a::hsky {
    struct HSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSKY>(arg0, 6, b"Hsky", b"husky", x"48534b593a204d6f7265205468616e204a7573742061204d656d6541204e657720457261206f6620446563656e7472616c697a656420436f6d6d756e6974790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_fff70f5573.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

