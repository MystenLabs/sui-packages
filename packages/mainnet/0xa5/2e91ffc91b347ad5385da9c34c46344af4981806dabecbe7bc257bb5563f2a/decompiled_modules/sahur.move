module 0xa52e91ffc91b347ad5385da9c34c46344af4981806dabecbe7bc257bb5563f2a::sahur {
    struct SAHUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAHUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAHUR>(arg0, 6, b"SAHUR", b"Tun Tun Tun Sahur", b"Tun Tun Tun Sahur is a terrifying anomaly in the form of a night patrol drum. Legend has it that if you are called for Sahur three times and don't respond, it will appear and haunt you. Its sound resembles that of a beating drum, \"tun tun tun.\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sahur_c3bac4cdc5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAHUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAHUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

