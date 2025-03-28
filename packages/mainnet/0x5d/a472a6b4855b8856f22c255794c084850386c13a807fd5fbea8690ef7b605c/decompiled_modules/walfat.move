module 0x5da472a6b4855b8856f22c255794c084850386c13a807fd5fbea8690ef7b605c::walfat {
    struct WALFAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALFAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALFAT>(arg0, 6, b"WALFAT", b"Walrus Fat Coin", x"57616c727573204661742069732061207374726f6e670a6d656d65636f696e20746861742077617320626f726e206f6e207468650a537569206e6574776f726b2c206c696b65206974732073686170652c0a57616c727573204661742077696c6c20626520626967676572207468616e0a65787065637465642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076451_ce4b51f466.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALFAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALFAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

