module 0x6f5790eb6dfe812fb23d780881fdd3ec1f6c0e2805e5d9eacfc4b335bc91263d::bururu {
    struct BURURU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURURU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURURU>(arg0, 6, b"BURURU", b"BURURUsui", x"4255525552550a5448452050726f746563746f72206f6620537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sqc_Ena_KB_400x400_36bdb1d672.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURURU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURURU>>(v1);
    }

    // decompiled from Move bytecode v6
}

