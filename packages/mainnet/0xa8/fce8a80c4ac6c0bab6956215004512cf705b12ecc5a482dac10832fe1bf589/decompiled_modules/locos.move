module 0xa8fce8a80c4ac6c0bab6956215004512cf705b12ecc5a482dac10832fe1bf589::locos {
    struct LOCOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCOS>(arg0, 6, b"LOCOS", b"PocoLocos", b"Meet PocoLocos: the wackiest pet mariachi band in town! With paws on strings, tails wagging to the beat, and sombreros slightly askew, theyre here to bring fiestas, fur, and a whole lot of loco to the stage!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_kcisit_nagyobb_943340cf7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

