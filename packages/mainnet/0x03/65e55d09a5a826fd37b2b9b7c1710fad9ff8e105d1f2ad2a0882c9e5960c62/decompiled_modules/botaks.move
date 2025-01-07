module 0x365e55d09a5a826fd37b2b9b7c1710fad9ff8e105d1f2ad2a0882c9e5960c62::botaks {
    struct BOTAKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTAKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTAKS>(arg0, 9, b"BOTAKS", b"BOTAK JAYA", b"Botak gundul plontos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f8780d2-47d9-4cbe-8631-5be94e89107e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTAKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOTAKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

