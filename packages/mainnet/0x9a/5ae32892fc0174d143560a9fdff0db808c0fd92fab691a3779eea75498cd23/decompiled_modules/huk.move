module 0x9a5ae32892fc0174d143560a9fdff0db808c0fd92fab691a3779eea75498cd23::huk {
    struct HUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUK>(arg0, 9, b"HUK", b"ry", b"sf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58cd4efb-548a-45fc-9d68-7464c67691a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

