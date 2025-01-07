module 0x25dc9acb80632fb78dbc6d8572ba68ea3d49ae04a2f24efcaa2019189a59f0d::picker {
    struct PICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICKER>(arg0, 9, b"PICKER", b"Wow", b"Let's be fast to know what is next on meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c331fd9-374c-4d24-b630-c9a8b5f18735.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

