module 0x23605df195ecdea4736cbc9d3e8ae2f9a424301fc976c3d496ab03140e5b7597::wow {
    struct WOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOW>(arg0, 9, b"WOW", b"Wowa", b"Nice token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93af09fc-0b4a-4190-ac3b-64d239536535.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

