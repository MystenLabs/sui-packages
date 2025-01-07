module 0xa7d29fd3d6a1e27bab59b04248f4792b30ffb0067a8735c487525930815db8f5::kinggg {
    struct KINGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGGG>(arg0, 6, b"KINGGG", b"KINGGGGSUI", b"BOW TO YOUR KING  AND HE WILL BRING YOU THE GLORY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/king_1500f26cf8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

