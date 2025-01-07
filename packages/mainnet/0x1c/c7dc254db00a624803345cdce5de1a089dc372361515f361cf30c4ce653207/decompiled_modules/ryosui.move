module 0x1cc7dc254db00a624803345cdce5de1a089dc372361515f361cf30c4ce653207::ryosui {
    struct RYOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYOSUI>(arg0, 6, b"Ryosui", b"Ryosui is back", b"The peoples  token.  True decentralization, community is everything.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/YMFI_cwi_400x400_6ca6d98e5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RYOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

