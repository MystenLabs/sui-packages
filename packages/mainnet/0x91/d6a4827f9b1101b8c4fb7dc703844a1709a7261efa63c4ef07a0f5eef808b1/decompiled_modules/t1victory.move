module 0x91d6a4827f9b1101b8c4fb7dc703844a1709a7261efa63c4ef07a0f5eef808b1::t1victory {
    struct T1VICTORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: T1VICTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T1VICTORY>(arg0, 6, b"T1Victory", b"T1 - World Champ 2024", b"Celebrating 5 World Championships", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_WTT_Loc_T_400x400_87266621bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1VICTORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T1VICTORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

