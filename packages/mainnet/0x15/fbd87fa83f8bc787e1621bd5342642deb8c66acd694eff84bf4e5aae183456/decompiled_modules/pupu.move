module 0x15fbd87fa83f8bc787e1621bd5342642deb8c66acd694eff84bf4e5aae183456::pupu {
    struct PUPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPU>(arg0, 9, b"PUPU", b"Pupu", b"Pupu To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e668ef28-7e97-4e1a-bee1-d323d2483c98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

