module 0xf07d8f23883c8fb774d839163d7c8fd0646c0228003b45314c773b303985b7a6::stoner {
    struct STONER has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONER>(arg0, 6, b"STONER", b"Sui Stoner", b"Buy high, sell higher.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241228_024445_970_65659daf29.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONER>>(v1);
    }

    // decompiled from Move bytecode v6
}

