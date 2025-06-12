module 0xb4d6c00f7d58bc5190ddcfcb712c8476a84c33dcd835ec18a77fcb6891e5946b::oshaaa {
    struct OSHAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSHAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSHAAA>(arg0, 6, b"OSHAAA", b"Oshaaa Sui", b"Oshaaa oshaaa oshaaa.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmlvmjwv5tso2qok7ea3k3vax2zphoqiodizue6igo4chzamcsya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSHAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OSHAAA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

