module 0x69f9f6b970d745a16713d9d9b9bb0b1cbc66fe969cf30fecf017ec2acdfbc36c::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 6, b"SHARK", b"SUI SHARK", x"53554920534841524b203a20746865206f6e6c7920736861726b207377696d6d696e6720696e2074686520537569206f6365616e2e0a0a24534841524b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_SHARK_f0477867c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

