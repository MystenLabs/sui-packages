module 0xf42daafe0b9c99d2549eec0724a2b3b880c8cc6132c6cd9187f604fbb9b930e6::mhaygfsf {
    struct MHAYGFSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHAYGFSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHAYGFSF>(arg0, 9, b"Mhaygfsf", b"8888", b"666", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/edb110572c46f09f2d8b7df1930d837fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHAYGFSF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHAYGFSF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

