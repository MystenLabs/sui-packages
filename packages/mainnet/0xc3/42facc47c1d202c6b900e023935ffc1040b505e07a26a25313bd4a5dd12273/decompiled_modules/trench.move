module 0xc342facc47c1d202c6b900e023935ffc1040b505e07a26a25313bd4a5dd12273::trench {
    struct TRENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCH>(arg0, 6, b"TRENCH", b"Trench Fighters", b"Youre probably wondering what $TRENCH is, arent you, recruit? Well, heres your answer: Its not for the faint of heart. $TRENCH is a meme coin forged in the fires of the Ethereum blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rw_Bgm6_QR_400x400_aba937fd3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRENCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

