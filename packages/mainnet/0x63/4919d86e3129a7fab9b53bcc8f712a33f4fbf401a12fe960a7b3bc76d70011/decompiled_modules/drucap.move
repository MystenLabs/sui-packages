module 0x634919d86e3129a7fab9b53bcc8f712a33f4fbf401a12fe960a7b3bc76d70011::drucap {
    struct DRUCAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRUCAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRUCAP>(arg0, 9, b"DRUCAP", b"Drunkard ", b"Memory of palmwine and local hand made drinks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8548d1b-26aa-4edc-8086-b7654286a151.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRUCAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRUCAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

