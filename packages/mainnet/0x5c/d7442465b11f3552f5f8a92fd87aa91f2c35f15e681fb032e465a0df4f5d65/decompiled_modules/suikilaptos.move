module 0x5cd7442465b11f3552f5f8a92fd87aa91f2c35f15e681fb032e465a0df4f5d65::suikilaptos {
    struct SUIKILAPTOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKILAPTOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKILAPTOS>(arg0, 6, b"SuiKilAptos", b"SuiKillAptos", b"Suiill kill aptos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hustle_hard_qwz18liuuomsh4o0_563672e106.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKILAPTOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKILAPTOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

