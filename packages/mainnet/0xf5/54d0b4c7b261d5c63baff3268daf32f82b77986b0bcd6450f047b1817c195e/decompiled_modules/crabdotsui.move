module 0xf554d0b4c7b261d5c63baff3268daf32f82b77986b0bcd6450f047b1817c195e::crabdotsui {
    struct CRABDOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABDOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CRABDOTSUI>(arg0, 6, b"CRABDOTSUI", b"CrabDotSui", b"SCRAB..1..launches..is..a decentralized meme coin built", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000066314_f1c99e9213.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRABDOTSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABDOTSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

