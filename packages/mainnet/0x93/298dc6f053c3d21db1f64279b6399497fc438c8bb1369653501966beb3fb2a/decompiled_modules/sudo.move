module 0x93298dc6f053c3d21db1f64279b6399497fc438c8bb1369653501966beb3fb2a::sudo {
    struct SUDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDO>(arg0, 6, b"SUDO", b"SURFER DOGE", b"SURFER DOGE is here to claim his throne as the leading dog coin on the Sui chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_d7b32f05be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

