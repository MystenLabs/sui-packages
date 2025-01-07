module 0x7f1f25ebfc5dd3d38e0b82c3162f207f8110d76d4cf519dc29be2beb0ce8e24b::suiwars {
    struct SUIWARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWARS>(arg0, 6, b"SUIWARS", b"Sui Wars", b"May the pump be with you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_output_0ead44ac4f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

