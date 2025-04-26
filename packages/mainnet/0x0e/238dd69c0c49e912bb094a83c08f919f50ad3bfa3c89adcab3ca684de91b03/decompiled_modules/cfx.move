module 0xe238dd69c0c49e912bb094a83c08f919f50ad3bfa3c89adcab3ca684de91b03::cfx {
    struct CFX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFX>(arg0, 9, b"CFX", b"Chain Fox", b"Your own ultimate shield in the crypto realm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdNuszFcPeh3UBGXkrB3jYgfX2pEGqDQsj2rxHFkL2JGj")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CFX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

