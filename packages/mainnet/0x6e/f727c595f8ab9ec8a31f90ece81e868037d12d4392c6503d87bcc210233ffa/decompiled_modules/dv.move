module 0x6ef727c595f8ab9ec8a31f90ece81e868037d12d4392c6503d87bcc210233ffa::dv {
    struct DV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DV>(arg0, 9, b"DV", b"Dove", b"Just like a dove in the sky, fly free.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16767e31-6a31-4594-95f3-bed1bfa1ec45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DV>>(v1);
    }

    // decompiled from Move bytecode v6
}

