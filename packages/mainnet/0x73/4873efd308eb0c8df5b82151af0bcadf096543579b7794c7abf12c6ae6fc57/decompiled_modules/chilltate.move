module 0x734873efd308eb0c8df5b82151af0bcadf096543579b7794c7abf12c6ae6fc57::chilltate {
    struct CHILLTATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLTATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLTATE>(arg0, 6, b"CHILLTATE", b"JUST A CHILL TATE", b"When someone says $CHILLTATE is just a meme, but you're a Chill Tate who doesn't give a fuck because memes made millionaires.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/345_b0db9be0d8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLTATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLTATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

