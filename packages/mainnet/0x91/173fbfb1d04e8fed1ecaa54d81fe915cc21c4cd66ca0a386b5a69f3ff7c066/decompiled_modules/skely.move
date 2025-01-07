module 0x91173fbfb1d04e8fed1ecaa54d81fe915cc21c4cd66ca0a386b5a69f3ff7c066::skely {
    struct SKELY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKELY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKELY>(arg0, 6, b"Skely", b"Hop Sui Skely ", b"Unveiling the first $Skely on @SuiNetwork! Hop Sui Skely is arriving on app.turbos.finance/fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731333280113.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKELY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKELY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

