module 0xf169a9ff07b3109aaa9fbbd5a5dd0625ecb42bcfc7df5ce05ec7384342ad6a32::zooworld {
    struct ZOOWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOOWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOOWORLD>(arg0, 6, b"ZOOWORLD", b"The Zoo World", x"414343455353494e4720544845205a4f4f20574f524c44204d41494e4652414d452e2e2e0a4b454550455220414343455353204752414e5445440a494e4954494154494e47204c4f4720454e5452593a20245a4f4f574f524c440a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_Gq_Xa_Vjj_Qy4h3qgqgz_T9_Trzy_A_Gq_Hm_B_Khg_Qw_W1_V_Fmeme_16295166aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOOWORLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOOWORLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

