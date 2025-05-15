module 0x9b4685924bafea932348f2c9085807bb01bb034d2517278ed93eac2dcd305856::picard {
    struct PICARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICARD>(arg0, 6, b"PICARD", b"Picardchu", b"Make it sui-o...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeickhdyrv3viqj7w5nrs7u5ljw4jvbgoyfmgric3e4tovtymuifl3a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PICARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

