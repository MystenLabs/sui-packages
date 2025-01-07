module 0x19b28779f84a1cf592fc5685d2bdb7b9bf58bf7c6a5ae9e402e22dfe23d85287::scd {
    struct SCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCD>(arg0, 6, b"SCD", b"Suicide", b"test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suic_8835f490a2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

