module 0xb9e1e5aef13b5ca4065c34e71a7153190dac936a15510cb48a86400d0b07270b::uru {
    struct URU has drop {
        dummy_field: bool,
    }

    fun init(arg0: URU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URU>(arg0, 9, b"URU", b"Urusai", b"Just shut up and buy this shit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20c47682-1a4c-4ce0-8d3a-c973dee24ea1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<URU>>(v1);
    }

    // decompiled from Move bytecode v6
}

