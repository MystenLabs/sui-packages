module 0x33cbbc11127bdf0a9468bccf0ee18398a8785efeb804cf40ab084c7d56ed4ba8::elodogs {
    struct ELODOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELODOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELODOGS>(arg0, 6, b"ELODOGS", b"Dogs WOOF WOOF", b"Everyone loves dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.hydropump.xyz/logo/01JCG9AYJ70Y9HY0SG13ZV7SAE/01JCGA1CG580BBBNC1FWDGHTQP")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELODOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELODOGS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

