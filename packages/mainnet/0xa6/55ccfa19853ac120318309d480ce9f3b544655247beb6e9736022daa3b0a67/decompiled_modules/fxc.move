module 0xa655ccfa19853ac120318309d480ce9f3b544655247beb6e9736022daa3b0a67::fxc {
    struct FXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FXC>(arg0, 9, b"FXC", b"FOXCOIN", b"Little cold foxy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a4c2b4a-4f92-4258-a7fa-f2a9e5db7331.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

