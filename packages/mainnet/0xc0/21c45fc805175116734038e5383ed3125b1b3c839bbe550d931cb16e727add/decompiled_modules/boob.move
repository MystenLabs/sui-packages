module 0xc021c45fc805175116734038e5383ed3125b1b3c839bbe550d931cb16e727add::boob {
    struct BOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOB>(arg0, 9, b"BOOB", b"Big Boob", b"Big boob girl meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2a68dd5-fb08-4b3f-9d44-ca4bb1915534.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

