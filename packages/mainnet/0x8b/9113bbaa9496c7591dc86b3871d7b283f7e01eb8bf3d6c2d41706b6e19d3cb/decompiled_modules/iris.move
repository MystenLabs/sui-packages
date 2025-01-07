module 0x8b9113bbaa9496c7591dc86b3871d7b283f7e01eb8bf3d6c2d41706b6e19d3cb::iris {
    struct IRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRIS>(arg0, 6, b"Iris", b"Iris AI Agent", b"Frist AI Agent On Sui, with all the daily content auto generated for SUI degen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730977312694.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

