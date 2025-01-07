module 0xe43ac9071c02af0c18021f04330130cd24ff19f3283ccd9135ba7c50af542048::yukiai {
    struct YUKIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKIAI>(arg0, 6, b"YUKIAI", b"YUKI", b"THIS TOKEN IS NOT A MEME TOKEN BUT AN AI LIKE CHATGPT BUT THIS AI IS THE LATEST VERSION. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735129008431.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUKIAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKIAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

