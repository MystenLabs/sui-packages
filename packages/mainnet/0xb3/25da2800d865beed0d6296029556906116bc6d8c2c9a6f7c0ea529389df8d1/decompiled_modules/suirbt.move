module 0xb325da2800d865beed0d6296029556906116bc6d8c2c9a6f7c0ea529389df8d1::suirbt {
    struct SUIRBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRBT>(arg0, 6, b"SUIRBT", b"SUIWEROBOT", b"Elon Musk's new robot operates on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tesla_we_robot_rotaxi_unveiling_event_c7fb0eff35.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

