module 0xdbff7649929ace14e773e8b32b9f49c22189ee5383f015d6fcaf0d00b0818d34::nm {
    struct NM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NM>(arg0, 9, b"NM", b"NotMeme", b"This ain't just a meme token... it's is more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f06ebcb-40f9-416c-924d-28f799717d8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NM>>(v1);
    }

    // decompiled from Move bytecode v6
}

