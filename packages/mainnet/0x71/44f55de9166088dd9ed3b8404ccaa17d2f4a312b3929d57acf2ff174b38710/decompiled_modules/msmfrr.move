module 0x7144f55de9166088dd9ed3b8404ccaa17d2f4a312b3929d57acf2ff174b38710::msmfrr {
    struct MSMFRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSMFRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSMFRR>(arg0, 9, b"MSMFRR", b"Mma", b"Masumfirari ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/258d93cb-3e05-4f86-966e-112c290b14e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSMFRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSMFRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

