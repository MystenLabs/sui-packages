module 0x90d681dc4afefca8578f982ba94a9ea3c0502b26c9708393664fe8971f72c65d::rufus {
    struct RUFUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUFUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUFUS>(arg0, 6, b"RUFUS", b"Rufus", b"RUFUS is an adorable doggy mascot. With the meme creator everyone can create rufus memes in seconds. $RUFUS will be seen everywhere.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Yr_ZG_8d8267u_Gt9pq_CW_5tv_AS_4h_A_Lh9myac_Y7_JRRR_Tu4t_0a6b850a02.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUFUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUFUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

