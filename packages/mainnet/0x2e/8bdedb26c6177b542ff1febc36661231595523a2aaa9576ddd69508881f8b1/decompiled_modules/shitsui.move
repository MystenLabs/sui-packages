module 0x2e8bdedb26c6177b542ff1febc36661231595523a2aaa9576ddd69508881f8b1::shitsui {
    struct SHITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITSUI>(arg0, 6, b"SHITSUI", b"Shitsui", b"SHIT SUI, the cutest little Shih Tzu on the SUI Network, trots through the blockchain with a wagging tail and a mischievous grin. With every playful step, this adorable pup spreads joy and charm, turning each transaction into a heartwarming adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001896_bbe9181591.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

