module 0x88f62f2a6e925c93318e1b281fca27f22a4eb39c616879a12958d3f21b822e3e::suirobot {
    struct SUIROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROBOT>(arg0, 6, b"SUIROBOT", b"SUIROBOT CTO", b"SUIROBOT was inspired by We Robot: SUI is the Chain We Want. SUIROBOT starts off as robotic meme on SUI but would in future venture in AI, Ride Hailing and more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_robot_3b7076a1ae.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

