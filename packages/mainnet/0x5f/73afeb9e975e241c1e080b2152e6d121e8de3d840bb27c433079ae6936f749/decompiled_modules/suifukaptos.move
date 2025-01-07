module 0x5f73afeb9e975e241c1e080b2152e6d121e8de3d840bb27c433079ae6936f749::suifukaptos {
    struct SUIFUKAPTOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUKAPTOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUKAPTOS>(arg0, 6, b"SuifukAptos", b"SuiKillAptos", b"Suiill kill aptos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hustle_hard_qwz18liuuomsh4o0_563672e106.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUKAPTOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUKAPTOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

