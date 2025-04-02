module 0x685fe68f43088254bd8d2bdcb5084b3b4a532496b41ce1c5f48bbf47a0d1699a::sevenkmeow {
    struct SEVENKMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEVENKMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEVENKMEOW>(arg0, 9, b"SEVENKMEOW", b"7KMEOW", b"7KMEOW  coming to you will you adopt?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e4a7e0adb7035ec5b338be145d60b032blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEVENKMEOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEVENKMEOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

