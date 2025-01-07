module 0xa0cf3d4b9e9477b60dfecf8369ada2985147a5a830b12fbcdd61eaf6185a46fa::mls {
    struct MLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLS>(arg0, 9, b"MLS", b"Miles", b"MLS is aiming to hit above 1$. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/400d3bf2-f15c-454c-bc91-0718fc20aeff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

