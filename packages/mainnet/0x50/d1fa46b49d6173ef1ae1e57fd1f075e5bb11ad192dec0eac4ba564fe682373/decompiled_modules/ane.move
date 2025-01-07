module 0x50d1fa46b49d6173ef1ae1e57fd1f075e5bb11ad192dec0eac4ba564fe682373::ane {
    struct ANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANE>(arg0, 9, b"ANE", b"Arinze", b"Nice meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b761b0b7-0539-42de-a587-6fdb7a3019b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

