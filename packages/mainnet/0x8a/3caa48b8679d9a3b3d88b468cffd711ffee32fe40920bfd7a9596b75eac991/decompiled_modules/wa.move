module 0x8a3caa48b8679d9a3b3d88b468cffd711ffee32fe40920bfd7a9596b75eac991::wa {
    struct WA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WA>(arg0, 6, b"WA", b"Whale Alert", b"Whale Alert is a memecoin and social experiment designed to observe if large cryptocurrency holders (whales) and smaller investors (fishes) can unite to create a cohesive and flowing market chart. The project tests the dynamics between these groups, aiming to visualize their collective behavior in the volatile crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xz_Ji_U_Wpw_TC_48_UM_Em_Z5frj_H6d_Q_Px_Xph_Brj_QBW_36uj_Xzn_Z_f1159d62b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WA>>(v1);
    }

    // decompiled from Move bytecode v6
}

