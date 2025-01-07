module 0xb508ceb938287df0067ee9e1ec95fea196111dce5aac17775356865f11e41dcd::wgf {
    struct WGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGF>(arg0, 9, b"WGF", b"Wing fly", b"The wing fly meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43afc536-7ce7-4165-8c2f-8c659a0ac9c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

