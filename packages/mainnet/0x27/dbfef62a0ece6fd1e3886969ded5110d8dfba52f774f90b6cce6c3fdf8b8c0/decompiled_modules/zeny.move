module 0x27dbfef62a0ece6fd1e3886969ded5110d8dfba52f774f90b6cce6c3fdf8b8c0::zeny {
    struct ZENY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENY>(arg0, 6, b"Zeny", b"Zenycoin", b"zenycoin girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/red_141cc75b1e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZENY>>(v1);
    }

    // decompiled from Move bytecode v6
}

