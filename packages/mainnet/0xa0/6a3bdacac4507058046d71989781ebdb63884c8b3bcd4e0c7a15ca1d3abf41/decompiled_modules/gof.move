module 0xa06a3bdacac4507058046d71989781ebdb63884c8b3bcd4e0c7a15ca1d3abf41::gof {
    struct GOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOF>(arg0, 6, b"GOF", b"Game Of Sui", b"Game of Sui $GOS Valar morghulis \"All memecoins must die\" We want to climb the iron throne", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000522_988cf10f85.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

