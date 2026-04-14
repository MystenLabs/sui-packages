module 0xbf62bb671251f9316ce7a7ec1f392f3f150f51bdc96e45fb6f49d4acf2eeb4de::xchat {
    struct XCHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCHAT>(arg0, 9, b"XCHAT", b"X CHAT Token", b"Elon Chat Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776161832030-169b7f45bdc90aacd910ef8157f9dc74.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<XCHAT>>(0x2::coin::mint<XCHAT>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XCHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCHAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

