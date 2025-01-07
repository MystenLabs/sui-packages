module 0x7ec6f26ff75041439a1dc6551ac7cbf6a44dda42927d0c917aeee67b6afc2962::gdm {
    struct GDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDM>(arg0, 9, b"GDM", b"Gundam ", b"Token for Gundam fans around the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11f61796-32a2-4557-be6b-c7070d2fed02.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDM>>(v1);
    }

    // decompiled from Move bytecode v6
}

