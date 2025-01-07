module 0xf24fc45a2d00d7032e86625f7de09bd2aa0f2cd9df9b8b2df9671e9bf4d864da::guanguan {
    struct GUANGUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUANGUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUANGUAN>(arg0, 6, b"GuanGuan", b"GuanYin Coin", x"546f2063656c656272617465204775616e59696e204269727468203174680a6c6f7665206775616e6775616e2121210a6c6f76652079696e79696e212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/14fa726fc14e9394b14466436d8232b_47483b0bdb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUANGUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUANGUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

