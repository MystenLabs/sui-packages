module 0x30b5488bde5ee5ae6f20d0da06b48bc7d3df5699ba16766a6242e9f0101f4125::togi {
    struct TOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOGI>(arg0, 6, b"TOGI", b"Togi", b"Togi the jungle catto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xz_Gs6_D_Xg_A_Az_Xfk_30b222110d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

