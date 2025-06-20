module 0xb4d38e101429aa09c89dcead6fbac274c276e0feb21d18e301743cc01b8c897e::lbb {
    struct LBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBB>(arg0, 6, b"LBB", b"labubu", b"LABUBU LABUBU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750403731824.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

