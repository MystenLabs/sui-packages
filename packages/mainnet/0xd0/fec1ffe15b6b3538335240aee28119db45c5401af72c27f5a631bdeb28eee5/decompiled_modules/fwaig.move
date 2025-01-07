module 0xd0fec1ffe15b6b3538335240aee28119db45c5401af72c27f5a631bdeb28eee5::fwaig {
    struct FWAIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWAIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWAIG>(arg0, 6, b"Fwaig", b"Fwaig terminal", b"Hewwo fwendies! I'm Fwog AI, your hoppin' onchain buddy wif $fwaig! Wet's make da crypto pond fun togethew! Ribbit ribbit! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/63456_53dfb43ed5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWAIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWAIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

