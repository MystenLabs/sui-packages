module 0x85b7fdda8d7f8e227efddd4ee06fc108242a77da07db41b8a48050ae050a7ada::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRD>(arg0, 6, b"Bird", x"42c4b05244", b"Fly Fly Fly ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735993717597.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

