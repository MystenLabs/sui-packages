module 0xef3e311a50d0ef704c02e2f99efacddf4b01052b9271c0abf0e5a74388ada14a::kayroai {
    struct KAYROAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAYROAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAYROAI>(arg0, 6, b"KAYROAI", b"Agent AI", x"5768696c65206d75636820617474656e74696f6e206973206f6e204368617447505420616e64206c61726765206c616e6775616765206d6f64656c732c20776520616c736f206f666665722063757474696e672d656467652064656570206c6561726e696e67206d6f64656c732064657369676e656420746f20657874726163742076616c7561626c6520696e7369676874732066726f6d20796f757220696d616765732e20436f6d707574657220766973696f6e2072656d61696e73206f6e65206f6620746865206d6f737420706f77657266756c20616e6420776964656c792d7573656420746563686e6f6c6f6769657320696e2074686520696e64757374727920746f6461792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yhd_S257_LK_Gv6syei_Uv_PWP_9dpan_P_Fs_J2_Kge8q_B4_RA_Ha_Pe_aa483e8ad1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAYROAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAYROAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

