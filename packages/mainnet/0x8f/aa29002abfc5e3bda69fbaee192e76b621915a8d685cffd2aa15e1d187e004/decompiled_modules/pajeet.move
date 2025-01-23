module 0x8faa29002abfc5e3bda69fbaee192e76b621915a8d685cffd2aa15e1d187e004::pajeet {
    struct PAJEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAJEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAJEET>(arg0, 9, b"PAJEET", b"Official Indian Coin", b"$PAJEET - The Official Indian Coin: The first coin to truly harness the unstoppable power of Indian hustle and maximum jugaad (Google it if you dont know).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPyLaAF6TM9prqbx1jw9peCBFwXqDyCbb9PsFhPwuW1ZH")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAJEET>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAJEET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAJEET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

