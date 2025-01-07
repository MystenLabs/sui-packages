module 0xc92748f7d17c94442e215da1d3605963b2d7b6c3397a624c8991f96b8422132d::wan {
    struct WAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAN>(arg0, 9, b"WAN", b"Wancat", b"Wancat is a meme for the community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79584b18-81d4-4f0e-9693-ef3227baeac3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

