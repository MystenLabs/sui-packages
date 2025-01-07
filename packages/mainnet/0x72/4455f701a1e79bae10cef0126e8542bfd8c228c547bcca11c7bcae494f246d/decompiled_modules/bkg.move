module 0x724455f701a1e79bae10cef0126e8542bfd8c228c547bcca11c7bcae494f246d::bkg {
    struct BKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKG>(arg0, 9, b"BKG", b"Bear King", b"Bear King Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7fcadbe3-4b1b-4a1b-970a-be8dcd495e90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

