module 0x73d772e4b0100beefd8b8080a5f7b1b4bcae89cc3dce439eddf366a52d30f7e7::swarm {
    struct SWARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARM>(arg0, 6, b"SWARM", b"SuiSwarm", b"SuiSwarm Token ($SWARM) merges blockchain innovation with a mission to save bees and promote sustainability. With real utility, transparent launch, and a community-driven vision, $SWARM empowers holders while supporting a vital environmental cause. Join the movement and make an impact today.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_04_18_40_50_A_bold_and_compact_futuristic_coin_logo_for_the_Swarm_token_designed_to_stand_out_even_at_smaller_sizes_Photoroom_b25ce8393b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

