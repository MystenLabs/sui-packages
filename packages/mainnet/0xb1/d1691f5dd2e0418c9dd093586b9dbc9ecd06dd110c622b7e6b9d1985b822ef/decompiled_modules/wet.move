module 0xb1d1691f5dd2e0418c9dd093586b9dbc9ecd06dd110c622b7e6b9d1985b822ef::wet {
    struct WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WET>(arg0, 6, b"WET", b"WETonSUI", b"Amid the usual sea of tokens and coins, one stood out like a splash of cool water on a sweltering afternoon: $WET. Launched on the sleek, fast SUI blockchain, $WET isn't just another coin. It is a symbol of freedom, fun, and maybe a little bit of mischief.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_11_20_44_17_181b01949d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WET>>(v1);
    }

    // decompiled from Move bytecode v6
}

