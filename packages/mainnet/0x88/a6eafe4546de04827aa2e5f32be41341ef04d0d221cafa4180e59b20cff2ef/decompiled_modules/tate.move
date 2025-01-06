module 0x88a6eafe4546de04827aa2e5f32be41341ef04d0d221cafa4180e59b20cff2ef::tate {
    struct TATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATE>(arg0, 6, b"TATE", b"TatePrime", b"Prime Minister ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002639_ea2b7206f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

