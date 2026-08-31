module 0xb9e1b5c534dc70e356de8a1465fd297f5ca3776b7a1503b30163c0fd1e55a3b4::new_56b8a1fcd7ca8a7e {
    struct NEW_56B8A1FCD7CA8A7E has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEW_56B8A1FCD7CA8A7E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEW_56B8A1FCD7CA8A7E>(arg0, 0, b"NEW", b"New Coin", b"Pump-style launch token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suigift.fun/api/uploads/token-icons/1788184742072-4ccea22b-4888-4758-b37c-222d33d6c2bc.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEW_56B8A1FCD7CA8A7E>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<NEW_56B8A1FCD7CA8A7E>>(0x2::coin::mint<NEW_56B8A1FCD7CA8A7E>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEW_56B8A1FCD7CA8A7E>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

