module 0xeffb525a0cf8cb2f62b1534462152dc84d3f6ef85ce1d38e5e6022c8678d9106::pslt {
    struct PSLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSLT>(arg0, 6, b"PSLT", b"PEARLY SLOTH", b"Slow but steady, Pearly Sloth wins the meme race with style.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_041005109_1bd5e033af.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

