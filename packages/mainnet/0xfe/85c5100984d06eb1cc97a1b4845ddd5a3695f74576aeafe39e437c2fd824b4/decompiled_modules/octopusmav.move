module 0xfe85c5100984d06eb1cc97a1b4845ddd5a3695f74576aeafe39e437c2fd824b4::octopusmav {
    struct OCTOPUSMAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPUSMAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPUSMAV>(arg0, 6, b"Octopusmav", b"Octopus mav", b"Sui octopus ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000907018_97371124cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPUSMAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOPUSMAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

