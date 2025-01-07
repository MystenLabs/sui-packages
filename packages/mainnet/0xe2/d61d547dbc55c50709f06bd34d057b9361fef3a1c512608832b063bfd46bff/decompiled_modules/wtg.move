module 0xe2d61d547dbc55c50709f06bd34d057b9361fef3a1c512608832b063bfd46bff::wtg {
    struct WTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTG>(arg0, 9, b"WTG", b"Warthog ", b"Created it for warthog lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54eb8dbe-45db-4b1a-925e-4aed1df44569.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

