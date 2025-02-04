module 0x64ab51fd86e258a9852702a6caa4c62c31f415c1d8fcb185e92c40e89a5253f3::mrbsui {
    struct MRBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRBSUI>(arg0, 6, b"MRBSUI", b"MrBrexitSui", b"Welcome to Sui Network! Join us in creating a thriving MrBrexit community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_4854c7e61a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

