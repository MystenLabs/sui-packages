module 0x845c8e1ec97c45280a437385b4a79c3e9a3f1698f6abc1d49492340dbe8eea18::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"WUKONG", b"Wukong Sun", x"426c61636b204d7974683a2057756b6f6e670a4a6f75726e657920746f2074686520576573740a447261676f6e2042616c6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WUKONG_6c6a905b6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

