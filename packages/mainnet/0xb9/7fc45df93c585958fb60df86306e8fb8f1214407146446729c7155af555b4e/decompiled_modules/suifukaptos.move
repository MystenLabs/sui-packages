module 0xb97fc45df93c585958fb60df86306e8fb8f1214407146446729c7155af555b4e::suifukaptos {
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

