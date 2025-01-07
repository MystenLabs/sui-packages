module 0x4f5f044d11a5c49a26417cbf0d1befeadde9503485862ccef34bcfe23f6c52c5::gcat {
    struct GCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCAT>(arg0, 9, b"GCAT", b"GrannyCat ", b"A meme coin set to do 500x like WEWE is projected to do. Not plenty with a TS of 5 million. Don't snitch BUY now before it's limited.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11cf7731-50b3-4e89-af8c-40f2902b21e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

