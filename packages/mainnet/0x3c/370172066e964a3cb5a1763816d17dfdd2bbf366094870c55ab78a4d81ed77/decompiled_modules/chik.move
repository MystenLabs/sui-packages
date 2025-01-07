module 0x3c370172066e964a3cb5a1763816d17dfdd2bbf366094870c55ab78a4d81ed77::chik {
    struct CHIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIK>(arg0, 9, b"CHIK", b"Ayam", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ac9f5c9-1b24-4df0-aaeb-173d131fdb53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

