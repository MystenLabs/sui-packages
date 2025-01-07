module 0xcef6cea59da86badabb7c4e41ee0a99418ee5a84f6be4fff55f04367dcded8eb::pnk {
    struct PNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNK>(arg0, 9, b"PNK", b"Penk", x"4a757374206372756973696e6720f09f989c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8f31538-c85e-4add-bf43-82ad97fe96ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

