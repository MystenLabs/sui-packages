module 0xdae9eb6ece3d6f7771da9abe387a53ea3d24e0209f63030c196034e75bda5235::tos {
    struct TOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOS>(arg0, 9, b"TOS", b"Trillion", b"Trillion Dollars On Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f7d68c0-bbd4-481e-a753-885ac500f469.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

