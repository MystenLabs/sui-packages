module 0x51c2b20eeb2ed6930549eb15caccf2748d767ff49d1ba6a48ec7a6e602f3239f::tin {
    struct TIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIN>(arg0, 9, b"TIN", b"Tin", b"Just buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fda07b91-e0fb-4c64-8617-2eb833128f23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

