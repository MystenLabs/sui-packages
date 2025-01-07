module 0xc752306fdb2887f57f9d9e5ac38b56ecf348458fee8e9dcaaebeffedb081de54::echo {
    struct ECHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHO>(arg0, 9, b"ECHO", b"EchoX", b"EchoXRunner Command action with your voice in this thrilling 3D platformer, seamlessly blending with Web3 technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bfb0420888500f76ffb437ed7f0d5157blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECHO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

