module 0x48140cf28d094d67c4378b49fdd40e10f9ccdbf5eded543914d8436ed4e24415::bss {
    struct BSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSS>(arg0, 6, b"BSS", b"BIG SUI SPLASH", x"596f75206b6e6f772042696720426173732073706c61736820696620796f7527726520612067616d626c65723f0a4d65657420626967207375692073706c617368202442535320616e6420636174636820414c4c20464953480a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009059_ce3e23b9b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

