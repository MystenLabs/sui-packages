module 0x662edad4ca250bd1ef321469e591c566b1e21e0ba43422fbf975020e1f2a3335::aegis {
    struct AEGIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEGIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEGIS>(arg0, 9, b"AEGIS", b"AI DOGE", b"$AEGIS - THE FIRST DOG CREATED BY ARTIFICIAL INTELLIGENCE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUrJfQ5wUa5x5KhNugRuwMP5z9K9H6s6nsYcnnM4E8KJh")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AEGIS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AEGIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEGIS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

