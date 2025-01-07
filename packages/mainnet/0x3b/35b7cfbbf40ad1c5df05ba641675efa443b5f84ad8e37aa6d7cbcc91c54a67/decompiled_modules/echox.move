module 0x3b35b7cfbbf40ad1c5df05ba641675efa443b5f84ad8e37aa6d7cbcc91c54a67::echox {
    struct ECHOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHOX>(arg0, 9, b"ECHOX", b"EchoXRunner", b"Command action with your voice in this thrilling 3D platformer, seamlessly blending with Web3 technology. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e640a2936ff13e1864612c0df082ec40blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECHOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

