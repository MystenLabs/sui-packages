module 0x6b98058a7ce445a4e6a8d04e2c213b084b5eb30eb7555445c7d89ac71d29671::orch {
    struct ORCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCH>(arg0, 6, b"Orch", b"orchi", b"orochiw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiccpykuvazi6nwjtdyhvtv6x6v66nqihzgdhbuuvcsnh3cfy4kgym")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

