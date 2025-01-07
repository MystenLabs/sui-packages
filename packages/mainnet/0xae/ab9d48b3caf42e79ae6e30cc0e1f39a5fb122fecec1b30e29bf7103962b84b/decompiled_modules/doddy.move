module 0xaeab9d48b3caf42e79ae6e30cc0e1f39a5fb122fecec1b30e29bf7103962b84b::doddy {
    struct DODDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODDY>(arg0, 6, b"DODDY", b"First Doddy on Sui", x"466972737420446f646479206f6e205375692e68747470733a2f2f646f6464796f6e7375692e66756e0a2068747470733a2f2f782e636f6d2f4461646479446f6464795f5375690a68747470733a2f2f742e6d652f4461646479446f646479535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/img1_a7d7ed1f6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

