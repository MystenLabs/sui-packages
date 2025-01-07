module 0xa561a2c09f02fd9d23108cf89a9767650e2d29adc2913c2ecd0af42dcb439df0::fwogsui {
    struct FWOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOGSUI>(arg0, 6, b"FWOGSUI", b"FWOG ON SUI", b"First FWOG on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fwogsui_8e01fd3bec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

