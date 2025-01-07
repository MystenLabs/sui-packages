module 0x4fc206d43efa8a867a445d3c3044e17013896be02d8b84f3e49643bdb7c7174f::safe {
    struct SAFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFE>(arg0, 9, b"Safe", b"Safe Sui", b"Allow me to introduce $Safe. I'm creating Safe coin on the suI blockchain that I believe can not only make you wealthy but withstand the test of time. I believe in the Sui blockchain and its potential. I'm creating a token that I believe will grow nicely right along with Sui. Lets make $Safe the #1 altcoin on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2b4d603f97135dfa33354f5aab3045a6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAFE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

