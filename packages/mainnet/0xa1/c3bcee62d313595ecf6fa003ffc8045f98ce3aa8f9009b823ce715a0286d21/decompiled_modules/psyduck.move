module 0xa1c3bcee62d313595ecf6fa003ffc8045f98ce3aa8f9009b823ce715a0286d21::psyduck {
    struct PSYDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSYDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSYDUCK>(arg0, 6, b"PSYDUCK", b"SUIPSYDUCK", b"PSYDUCK is constantly stunned by his headache and wants to calm down in SUI ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PSYDUCK_SUI_82c6dee37b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSYDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSYDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

