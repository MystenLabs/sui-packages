module 0xaf3193220324ed66b54afddf74cc4be06c5869b5abc8e4d000a337974c9dd7f5::great {
    struct GREAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREAT>(arg0, 9, b"GREAT", b"Fefewe", b"Greatest meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2d31f15-068f-4f71-b07d-ebeed5e2e7c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

