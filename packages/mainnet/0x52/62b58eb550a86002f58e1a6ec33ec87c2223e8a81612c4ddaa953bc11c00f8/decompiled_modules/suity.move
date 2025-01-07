module 0x5262b58eb550a86002f58e1a6ec33ec87c2223e8a81612c4ddaa953bc11c00f8::suity {
    struct SUITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITY>(arg0, 6, b"SUITY", b"Suity", b"Embrace the charm of suiteness ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Toasty_21f2f79caf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

