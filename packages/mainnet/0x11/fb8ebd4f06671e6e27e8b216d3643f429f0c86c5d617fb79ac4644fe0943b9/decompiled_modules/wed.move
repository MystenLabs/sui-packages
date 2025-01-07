module 0x11fb8ebd4f06671e6e27e8b216d3643f429f0c86c5d617fb79ac4644fe0943b9::wed {
    struct WED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WED>(arg0, 9, b"WED", b"Wedeh", b"Trust is good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0aa100d4-10bf-4187-9740-4638bd2838e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WED>>(v1);
    }

    // decompiled from Move bytecode v6
}

