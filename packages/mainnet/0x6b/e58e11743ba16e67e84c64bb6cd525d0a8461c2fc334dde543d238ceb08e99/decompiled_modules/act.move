module 0x6be58e11743ba16e67e84c64bb6cd525d0a8461c2fc334dde543d238ceb08e99::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT>(arg0, 6, b"ACT", b"Act on Sui", b"ACT aims to maximize meme potential coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Anime_Humanoid_Animal_Bull_In_An_American_World_War_One_65791625_1_dd6fbdc58d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

