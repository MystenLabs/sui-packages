module 0xc96a046867e9139e91c32068af247b407860546ab4a9f737c7216670c2b79760::botaks {
    struct BOTAKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTAKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTAKS>(arg0, 9, b"BOTAKS", b"BOTAK JAYA", b"Botak gundul plontos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc687a4f-9e3c-4084-8d31-6c9b2b7c612b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTAKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOTAKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

