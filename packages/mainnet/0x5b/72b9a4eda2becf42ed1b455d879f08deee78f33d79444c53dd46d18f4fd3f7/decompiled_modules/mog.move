module 0x5b72b9a4eda2becf42ed1b455d879f08deee78f33d79444c53dd46d18f4fd3f7::mog {
    struct MOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOG>(arg0, 9, b"MOG", b"Chocobo", b"Inspired from Final Fanatsy Chocobo and mogle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/367fcc8b-14cd-4bbb-a5f5-afba395c4ae4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

