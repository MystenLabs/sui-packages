module 0x7bb6da77aecec312de6a45b926a2001ca2d3e51d9e719dddf17687376eaccfc7::wedogs {
    struct WEDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOGS>(arg0, 9, b"WEDOGS", b"Dog's", b"Lets do fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf90f532-abf0-4f00-8c54-20b37ebc9e16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

