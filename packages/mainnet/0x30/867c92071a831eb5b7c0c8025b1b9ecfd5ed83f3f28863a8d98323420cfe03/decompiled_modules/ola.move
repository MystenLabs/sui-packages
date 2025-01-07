module 0x30867c92071a831eb5b7c0c8025b1b9ecfd5ed83f3f28863a8d98323420cfe03::ola {
    struct OLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLA>(arg0, 9, b"OLA", b"Ole", b"Olale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97e1c65b-68d2-4aa8-ae13-a1f8ae88a528.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

