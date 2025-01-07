module 0x2064bd5c0f5ae4eaf19a1bce8eadd3b969d842e43a5fe0741811d6fc018fb5dc::alt {
    struct ALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALT>(arg0, 9, b"ALT", b"ALT", b"ALT COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

