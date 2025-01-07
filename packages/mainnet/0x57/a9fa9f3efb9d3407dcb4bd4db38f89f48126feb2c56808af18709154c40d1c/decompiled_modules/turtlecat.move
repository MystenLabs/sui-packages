module 0x57a9fa9f3efb9d3407dcb4bd4db38f89f48126feb2c56808af18709154c40d1c::turtlecat {
    struct TURTLECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTLECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLECAT>(arg0, 6, b"TURTLECAT", b"Turtle Cat", b"The perfect blend of speed and precision, Turtle Cat is a unique mascot for the SUI blockchain. With the steady determination of a turtle and the agility of a cat, Turtle Cat embodies SUIs balance of high performance and reliability. Fast, flexible, and always on the move, Turtle Cat represents the efficiency and smart technology powering the future of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_X_Djx_Noxt_BBFE_Wwm_Tn_G_Re6zn9p_Co8mqw_J_Lh_Fvt_Pp_Up_BY_8e4896251c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTLECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

