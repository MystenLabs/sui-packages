module 0xf5388701455faea7627ccf9658c3a6a54e552b3e8e8c64166a90745c509b7690::troppy {
    struct TROPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROPPY>(arg0, 6, b"TROPPY", b"Troppy", b"Troppy the Trippy tropical dart frog on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250509_015502_3799999553.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

