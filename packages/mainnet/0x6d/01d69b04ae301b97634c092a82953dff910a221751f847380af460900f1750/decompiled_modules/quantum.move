module 0x6d01d69b04ae301b97634c092a82953dff910a221751f847380af460900f1750::quantum {
    struct QUANTUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTUM>(arg0, 6, b"Quantum", b"Quantum Terminal", b"QUANTUM TERMINAL WILL BE INVESTING MAINLY INTO AL PROJECT. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004412_7fba82b703.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANTUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

