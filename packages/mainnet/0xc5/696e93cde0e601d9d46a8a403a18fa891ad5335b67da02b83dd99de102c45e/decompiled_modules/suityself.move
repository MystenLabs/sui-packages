module 0xc5696e93cde0e601d9d46a8a403a18fa891ad5335b67da02b83dd99de102c45e::suityself {
    struct SUITYSELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITYSELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITYSELF>(arg0, 6, b"SUItYself", b"Suityourself", x"546865204d656d6520436f696e2054686174204c65747320596f7520446f20596f7521200a57656c636f6d6520746f205355497420596f757273656c662c20746865206d656d6520636f696e20776865726520796f75206d616b65207468652072756c657321205768657468657220796f7527726520696e20666f7220746865206761696e732c20746865206c61756768732c206f72206a757374206865726520666f72207468652066756e2c205355497420596f757273656c6620676976657320796f75207468652066726565646f6d20746f20646f2063727970746f20796f7572207761792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_cute_meme_suit_you_2e170fe0c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITYSELF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITYSELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

