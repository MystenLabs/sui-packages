module 0xc7698ca5fbebe7697a75826319229afbba91cda67904e4f015cf99f4c8109d69::arena {
    struct ARENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARENA>(arg0, 6, b"ARENA", b"Sui Arena Battles  web3 PVP", b"An old-school RPG with pvp gaming experience & first gaming project $ARENA upcoming on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jl_YQV_2_Df_400x400_df1e8dc8fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

