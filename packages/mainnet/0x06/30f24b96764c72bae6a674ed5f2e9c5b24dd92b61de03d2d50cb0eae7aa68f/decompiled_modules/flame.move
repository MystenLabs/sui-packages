module 0x630f24b96764c72bae6a674ed5f2e9c5b24dd92b61de03d2d50cb0eae7aa68f::flame {
    struct FLAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAME>(arg0, 9, b"FLAME", b"Sunny", b"Sunshine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92aebb4f-318c-4eb7-a618-bbfc5c36c9b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

