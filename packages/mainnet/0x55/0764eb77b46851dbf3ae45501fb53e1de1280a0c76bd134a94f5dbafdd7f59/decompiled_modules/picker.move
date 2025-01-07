module 0x550764eb77b46851dbf3ae45501fb53e1de1280a0c76bd134a94f5dbafdd7f59::picker {
    struct PICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICKER>(arg0, 9, b"PICKER", b"Wow ", b"Let's be fast to know what is next on meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/778217f5-ef71-4ba5-af24-f57a8c4cf1c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

