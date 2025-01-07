module 0x5481fd53b8f673f6f6ec6ff0a24923b9a985b5d016b8cf3af4e2d11abdaa396d::suiger {
    struct SUIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGER>(arg0, 6, b"SUIGER", b"SuigerOnSui", b"MEME COIN ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000646_c489aa01a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

