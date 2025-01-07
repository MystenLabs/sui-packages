module 0xb911111b4ee3da94a72e895d22b3e6dc521c5666bc7853cdac4e76f6e789025b::spu {
    struct SPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPU>(arg0, 6, b"SPU", b"spudy", b"spu is the dev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_DG_4q_PN_Vke_3y_Ji_Tu_X_Wm1_HA_2402986661.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

