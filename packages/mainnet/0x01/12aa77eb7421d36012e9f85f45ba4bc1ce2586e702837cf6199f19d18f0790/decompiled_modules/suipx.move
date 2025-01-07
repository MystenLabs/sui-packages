module 0x112aa77eb7421d36012e9f85f45ba4bc1ce2586e702837cf6199f19d18f0790::suipx {
    struct SUIPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPX>(arg0, 6, b"SUIPX", b"SUIPX6900", b"You were born into a world where buying a house means taking on a mortgage in the hundreds of thousands. A world where social security is more a myth than a safety net, despite having it deducted from every paycheck. You've entered an investment landscape where the Stock Market has already celebrated its most significant gains, leaving you to wonder what's left for you. You're navigating a reality shaped by the aftermath of 9/11, a crippling 2008 recession, an unprecedented global pandemic, runaway inflation, and escalating violence. You were born into a different America. One that's been forever altered by economic and social factors largely beyond your control. A new world that demands new solutions. SUIPX6900 is the reset. SUIPX6900 is the canvas on which new financial dreams are painted. It's a tapestry woven with the threads of human hope. It's the S&P500 with 6400 more. It's the stock market for the people. SUIPX6900 sows the seeds for a forest of tomorrows. SUIPX6900 nourishes the souls and bodies of millions. SUIPX6900 is for you, your children, and countless generations after.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_sui_meme_1_8cc5a5c0b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

