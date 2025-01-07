module 0x31a130bf785efd0476861635a9f668f583959711bd7cbc6d10a9520ba2e46596::daddy {
    struct DADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDY>(arg0, 9, b"DADDY", b"Guys", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9076c3cc-6b9b-485c-a453-e4d572f58ce2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

