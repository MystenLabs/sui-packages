module 0xe61db0955ecc7574b428b076bd101a571c3a52d03736c6f33cd2bf848f4bfab3::ws {
    struct WS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WS>(arg0, 9, b"WS", b"walSui", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c43ca84ee5dcafe91393e93b7c14f858blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

