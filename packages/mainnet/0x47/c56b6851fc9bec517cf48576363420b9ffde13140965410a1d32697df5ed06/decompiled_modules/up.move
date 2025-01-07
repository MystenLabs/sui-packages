module 0x47c56b6851fc9bec517cf48576363420b9ffde13140965410a1d32697df5ed06::up {
    struct UP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UP>(arg0, 6, b"UP", b"Uptober", x"546f6b656e20656e746972656c792064656469636174656420746f20746865206d6f6e7468206f66204f63746f62657220323032342e0a0a50554d5020262043594245525345435552495459", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/liam4chill_Cute_animated_water_droplet_face_to_october_Rocket_ac60b704_c37c_4d51_9665_f8d207a2896e_ee4623607c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UP>>(v1);
    }

    // decompiled from Move bytecode v6
}

