module 0x769680f96f0786ebe92b46be7960f50585a37bb7f963ec64484a2d42e08ebefa::stopit {
    struct STOPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOPIT>(arg0, 6, b"STOPIT", b"Stop It Thanks", b"Stop It Thanks, YOU HAVE DONE ENOUGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaqmaifnk5q7ojfv2tk3grzavkg4bvc4rnvzyhrw4wf4lqhj6agdu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOPIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STOPIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

