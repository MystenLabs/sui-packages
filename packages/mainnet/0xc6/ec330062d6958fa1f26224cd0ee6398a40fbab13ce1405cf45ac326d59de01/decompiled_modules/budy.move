module 0xc6ec330062d6958fa1f26224cd0ee6398a40fbab13ce1405cf45ac326d59de01::budy {
    struct BUDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDY>(arg0, 7, b"BUDY", b"buddy", b"It is not just a dog it is Buddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUDY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

