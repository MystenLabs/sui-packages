module 0xa821f2abfcfb093dc8152fddcd8a007f9d4eb1c4058fd2a9686295898b3f0ee4::sim {
    struct SIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIM>(arg0, 6, b"Sim", b"Simba", b"Sim is another test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_ed5bf6c1b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

