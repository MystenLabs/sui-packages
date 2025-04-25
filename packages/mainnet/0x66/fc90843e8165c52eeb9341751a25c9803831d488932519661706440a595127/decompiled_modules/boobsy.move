module 0x66fc90843e8165c52eeb9341751a25c9803831d488932519661706440a595127::boobsy {
    struct BOOBSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBSY>(arg0, 6, b"Boobsy", b"Boobsy on Sui", b"Grab life by the boobs with Ballsy's wife, Boobsy is your unapologetic degen spirit animal Grab your Boobsy Hold tight and join the ride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihnzgm7qirfutwb7kp473jbk7khveqmslqmo2aqbgxfxstdhxm7la")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOBSY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

