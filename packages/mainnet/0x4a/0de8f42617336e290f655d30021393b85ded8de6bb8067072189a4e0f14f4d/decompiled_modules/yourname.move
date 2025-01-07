module 0x4a0de8f42617336e290f655d30021393b85ded8de6bb8067072189a4e0f14f4d::yourname {
    struct YOURNAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOURNAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOURNAME>(arg0, 9, b"YOURNAME", b"Your Name ", b"Your Name (2016) - Anime Movie shilled by Elon Musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e50b8da5-f527-4677-9d8f-d570d834f825.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOURNAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOURNAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

