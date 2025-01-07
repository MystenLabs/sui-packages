module 0x7bf5a08b00d642a0f7eee3001b6138b05e677593cf591382b9fa6f82f1fcfca5::catii {
    struct CATII has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATII>(arg0, 9, b"CATII", b"catii", x"636174206c6f76657273206d656d65636f696ef09fa48df09f988d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1caa038-a0ba-4c23-9a32-bf1779a20c93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATII>>(v1);
    }

    // decompiled from Move bytecode v6
}

