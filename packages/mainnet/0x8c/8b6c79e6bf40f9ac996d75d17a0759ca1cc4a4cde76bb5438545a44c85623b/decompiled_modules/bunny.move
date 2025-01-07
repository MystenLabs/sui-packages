module 0x8c8b6c79e6bf40f9ac996d75d17a0759ca1cc4a4cde76bb5438545a44c85623b::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 9, b"BUNNY", b"Bunny hop", b"A Royal Bunny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8fc37174-fbee-4196-a411-bf507e7da3df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

