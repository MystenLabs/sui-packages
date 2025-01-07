module 0xe72159c66e70c1b23223210bce7629ac1e5c0b77c6a6534254267085e49a6770::sfi {
    struct SFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFI>(arg0, 6, b"SFI", b"Sui fish", b"ere", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_ab35e6111f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

