module 0x7993afffda8e9258562af452b1b09d812a56a7548223043889cf0f51eeddb637::elonwewe {
    struct ELONWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONWEWE>(arg0, 9, b"ELONWEWE", b"EWE", b"King of memecoins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06bccb82-354f-49c3-ba18-8aa76056c01c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

