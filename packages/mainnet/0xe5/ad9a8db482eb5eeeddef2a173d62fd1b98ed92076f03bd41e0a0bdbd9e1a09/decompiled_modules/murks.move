module 0xe5ad9a8db482eb5eeeddef2a173d62fd1b98ed92076f03bd41e0a0bdbd9e1a09::murks {
    struct MURKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURKS>(arg0, 6, b"Murks", b"Murks Rise", b" Rising from the depths  #Murkz are taking over #sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Ttk_Hiq_400x400_bcd3048504.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

