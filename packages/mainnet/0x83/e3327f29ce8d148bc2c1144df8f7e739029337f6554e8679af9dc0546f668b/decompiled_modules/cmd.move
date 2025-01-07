module 0x83e3327f29ce8d148bc2c1144df8f7e739029337f6554e8679af9dc0546f668b::cmd {
    struct CMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMD>(arg0, 6, b"CMD", b"CATCH MOO DEENG", b"Baby moodeng , catch it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_nh_cha_p_m_A_n_h_A_nh_2024_10_07_213302_14a9c7303b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

