module 0x94d8c8b1158211628df01ea18cb2919b18ae8f44d7aacb426c2736fa8d761eec::meme2 {
    struct MEME2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME2>(arg0, 9, b"MEME2", b"MEME two", b"MEME Two", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/de84c8c6-c8f2-40ad-b01f-ebeb863c535d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME2>>(v1);
    }

    // decompiled from Move bytecode v6
}

