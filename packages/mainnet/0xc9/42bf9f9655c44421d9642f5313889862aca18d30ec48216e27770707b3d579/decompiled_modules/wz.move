module 0xc942bf9f9655c44421d9642f5313889862aca18d30ec48216e27770707b3d579::wz {
    struct WZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZ>(arg0, 9, b"WZ", b"WIZZWOODS", b"Community meme Coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4dc74516-ad6d-4a4a-9ad6-aaf42da76d49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

