module 0x6aceb4ae297ed2b4f82825011151f1a2440eda4c97b181157a549a5d81cc8d9::blark {
    struct BLARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLARK>(arg0, 9, b"BLARK", b"Black Shark", b"BlackShark Token is a revolutionary digital asset that represents power, speed, and dominance in the crypto world. Inspired by the black shark, the symbol of the greatest ocean predator, BLARK is designed to deliver high transaction efficiency, cutting-edge security, and a resilient ecosystem amidst volatile market waves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9c0cca195c1fcf4f796ddad6addec478blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

