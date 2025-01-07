module 0x3a6b7ba54d933e9e89382aaa0a931bcb457ae7f52842fc4f5a2ed72eefeb084c::echox {
    struct ECHOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHOX>(arg0, 9, b"ECHOX", b"EchoX AI", b"Command action with your voice in this thrilling 3D platformer, seamlessly blending with Web3 technology. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/17d5d6f39dbaa726e6cb2713c4d701ddblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECHOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

