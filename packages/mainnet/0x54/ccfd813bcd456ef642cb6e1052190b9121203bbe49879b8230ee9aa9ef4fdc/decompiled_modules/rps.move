module 0x54ccfd813bcd456ef642cb6e1052190b9121203bbe49879b8230ee9aa9ef4fdc::rps {
    struct RPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPS>(arg0, 6, b"RPS", b"RPS on SUI", b"Next-Gen Financial Gaming...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mo_a_Q3_Gb_400x400_fe54da15d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

