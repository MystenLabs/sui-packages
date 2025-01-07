module 0x3c9e094e2a9f4494295440301327e321e3f24e9a1e719b6edf1e0fff96ba9450::rarity {
    struct RARITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RARITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RARITY>(arg0, 6, b"RARITY", b"Rarity On SUI", b"We're thrilled to have you with us as we kick off the $RARITY journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_Z0k_E_Vcc_400x400_5dfb62e705.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RARITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RARITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

