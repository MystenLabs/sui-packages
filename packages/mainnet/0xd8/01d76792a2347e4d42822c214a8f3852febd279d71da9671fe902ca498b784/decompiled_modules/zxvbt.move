module 0xd801d76792a2347e4d42822c214a8f3852febd279d71da9671fe902ca498b784::zxvbt {
    struct ZXVBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXVBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZXVBT>(arg0, 9, b"ZXVBT", b"zxVictor Token Bullish!", b"In the year 2286, the USS Enterprise-D was on a routine mission when Captain Jean-Luc Picard stumbled upon a mysterious signal emanating from a distant galaxy. Upon investigation, they discovered a new cryptocurrency called zxVictor Token. The token's price began to skyrocket, and the crew, led by the ever-optimistic Lieutenant Commander Data, decided to invest heavily. Thanks to their strategic investments, the token's value continued to rise, leading to a monumental bull market in the galaxy's financial sector. The crew of the Enterprise-D became legendary for their foresight and wealth, and the zxVictor Token became the currency of choice for interstellar trade and investment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739205749/zm62fxkdfx5pxwlwhwbl.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZXVBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXVBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

