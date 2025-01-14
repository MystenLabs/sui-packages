module 0xe634489c28029c4e9f69456fe59f944a3f0f4246b58ab3e470dea345adb851be::suipika {
    struct SUIPIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIKA>(arg0, 6, b"SuiPika", b"Pika on SUI", b"Pika has arrived to SUI network to shock everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pikachu_profil_0e8ee42a87.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

