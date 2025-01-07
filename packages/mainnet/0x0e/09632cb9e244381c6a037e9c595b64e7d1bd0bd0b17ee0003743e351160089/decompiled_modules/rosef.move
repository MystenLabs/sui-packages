module 0xe09632cb9e244381c6a037e9c595b64e7d1bd0bd0b17ee0003743e351160089::rosef {
    struct ROSEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSEF>(arg0, 9, b"ROSEF", b"FLOWER", x"41206469676974616c2063757272656e637920746861742063656c65627261746573207468652074696d656c65737320616e6420726f6d616e74696320626561757479206f6620726f7365730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b0131d9-47f7-4774-8eea-b21641749dbb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROSEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

