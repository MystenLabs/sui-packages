module 0x9d1dd837244daf293730e009cabd1244f08cddc8d045b52caa470f63f697821f::youmi {
    struct YOUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUMI>(arg0, 9, b"YOUMI", b"You", b"Token of community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f007ab1a-e4ff-45f5-9347-fb33665a5737.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

