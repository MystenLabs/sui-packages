module 0x283f6ab34e42e66e9d50e0c33cf92442f4fb023b4dc52b690069b6a1a17c5034::smk {
    struct SMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMK>(arg0, 9, b"SMK", b"Sui Kombat", b"The First Mortal Kombat Token on Sui Blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a509ea7d-690e-4dda-8527-eefe6d495ac3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

