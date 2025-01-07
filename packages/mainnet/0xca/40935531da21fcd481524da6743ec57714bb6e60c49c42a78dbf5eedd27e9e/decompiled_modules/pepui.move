module 0xca40935531da21fcd481524da6743ec57714bb6e60c49c42a78dbf5eedd27e9e::pepui {
    struct PEPUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPUI>(arg0, 6, b"PEPUI", b"Pepe SUI", b"Pepe on Sui = $Pepui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screen_Shot_2024_09_30_at_9_45_25_PM_c4f2f4ab96.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

