module 0x3aad3ce6eae7fa2b6c44c5840bff95313c5e2b2b4069b3c2954ab60bea1432bc::mhaygfsf {
    struct MHAYGFSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHAYGFSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHAYGFSF>(arg0, 9, b"Mhaygfsf", b"8888", b"666", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b5d5e839a9fa424c5414b79f4088baf5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHAYGFSF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHAYGFSF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

