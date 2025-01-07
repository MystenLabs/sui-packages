module 0x7abf29dffdd63faf21ed51beec8bb3214acb08a093dc3bbe6ca2aaebd77022b4::vtnn66 {
    struct VTNN66 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTNN66, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTNN66>(arg0, 9, b"VTNN66", b"BaTho", b"Phan Bon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e93241e-8b2c-49fb-a10d-66b383d1061d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTNN66>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VTNN66>>(v1);
    }

    // decompiled from Move bytecode v6
}

