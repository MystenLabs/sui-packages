module 0x111c42a23170e418fa6324f05c077eb035f93d218370c9a1ef3df7dce8578b89::rawl {
    struct RAWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAWL>(arg0, 9, b"RAWL", b"RAWRR TANG", b"moustly its token meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15813ebc-727d-4439-a0a5-4dd4a47a8bcb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

