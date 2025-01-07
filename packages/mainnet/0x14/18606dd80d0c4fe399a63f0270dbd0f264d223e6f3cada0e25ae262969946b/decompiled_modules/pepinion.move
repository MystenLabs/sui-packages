module 0x1418606dd80d0c4fe399a63f0270dbd0f264d223e6f3cada0e25ae262969946b::pepinion {
    struct PEPINION has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPINION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPINION>(arg0, 6, b"PEPINION", b"Pepinion on SUI", b"Born from the unlikely fusion of Pepe's charm and the Minions' infectious joy. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vd2z_GQ_Vk_400x400_e38c3b0a92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPINION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPINION>>(v1);
    }

    // decompiled from Move bytecode v6
}

