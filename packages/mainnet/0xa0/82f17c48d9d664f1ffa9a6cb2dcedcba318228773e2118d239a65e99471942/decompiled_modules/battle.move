module 0xa082f17c48d9d664f1ffa9a6cb2dcedcba318228773e2118d239a65e99471942::battle {
    struct BATTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATTLE>(arg0, 6, b"BATTLE", b"BATTLEMON", x"43726f73732d636861696e2044796e616d6963204e465420706f7765726564206279200a404c617965725a65726f5f4c6162730a20776974682053686f6f7465722067616d65206f6e20554535", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TF_Ao_C_Nv_V_400x400_4b7e691308.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

