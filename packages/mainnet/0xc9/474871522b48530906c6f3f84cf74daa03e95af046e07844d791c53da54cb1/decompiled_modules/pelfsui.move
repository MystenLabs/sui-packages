module 0xc9474871522b48530906c6f3f84cf74daa03e95af046e07844d791c53da54cb1::pelfsui {
    struct PELFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELFSUI>(arg0, 6, b"PELFSUI", b"Pepe Elf On Sui", b"Official Pepe Elf On Sui : https://pepeelfsui.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_7_3b1db02eae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

