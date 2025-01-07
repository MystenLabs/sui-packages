module 0xda6ea96c93a501bd78d560d313e81e3b41b8642bd58009a7562b1cb92ecf3056::craft2 {
    struct CRAFT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAFT2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAFT2>(arg0, 6, b"Craft2", b"Minecraft 2", x"4e6f74636820686173206f6666696369616c6c7920616e6e6f756e636564204d696e6563726166742032206f6e2058210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nxejib_F_Szci7d_V1_Pv3g4x2f_B_Kqupgo72w_Dqfa_Ji98_J_Zb_106c729333.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAFT2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAFT2>>(v1);
    }

    // decompiled from Move bytecode v6
}

