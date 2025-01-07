module 0x9707cd7cdaceabbd20a70f38ebb3f9cfe81a371ab4b0cdb8c05a40cb29a2c22b::bacon {
    struct BACON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACON>(arg0, 6, b"BACON", b"BaconBucks", b"The crispiest memecoin in the crypto skillet!  Join the sizzle as we fry up fun, community, and profits. Swap, earn, and watch your wallet crisp up with the tastiest token on the blockchain. Time to bacon up!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000127970_bec023f07b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACON>>(v1);
    }

    // decompiled from Move bytecode v6
}

