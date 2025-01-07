module 0x2d53b9a3e8a753e2a1e5584cd6d0d1e486afee0006d752cafa73da9c70711d31::dy {
    struct DY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DY>(arg0, 9, b"DY", b"Deny", b"Lovers edge token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6c3a878-d5bf-48ec-b074-730e5084f4ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DY>>(v1);
    }

    // decompiled from Move bytecode v6
}

