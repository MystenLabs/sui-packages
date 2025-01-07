module 0xa4afa3809ce6f2759e2469c167b6596f89ff4a397d0c05d6601362cf6180be1f::wtg {
    struct WTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTG>(arg0, 9, b"WTG", b"Warthog ", b"Created it for warthog lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f618c4df-9b80-4bfc-95d0-f3c5d54e1671.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

