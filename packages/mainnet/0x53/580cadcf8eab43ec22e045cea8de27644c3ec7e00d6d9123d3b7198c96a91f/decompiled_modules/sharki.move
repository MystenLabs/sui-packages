module 0x53580cadcf8eab43ec22e045cea8de27644c3ec7e00d6d9123d3b7198c96a91f::sharki {
    struct SHARKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKI>(arg0, 6, b"SHARKI", b"sharki", b"the cutest shark on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SHARKY_3cb3e26ed4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

