module 0x8c5d1d1d806d4ede2dc299cd61930414c4e0ee3ae82da4588b15c4ec386f1c2e::fo {
    struct FO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FO>(arg0, 6, b"FO", b"Fred Octo", b"Fred Octo is in the SUI Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ON_Wqlvbz_400x400_c31749b944.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FO>>(v1);
    }

    // decompiled from Move bytecode v6
}

