module 0xe40ba680486ad0eb20993c3807db71cdcc3944bf2b4c4d2a5300bf28d02d902f::joesui {
    struct JOESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOESUI>(arg0, 6, b"Joesui", b"Joecoin on Sui", b"Joe on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieefowg6wqukzmidfeydr5ggbhzdyat43l4zlffp7fgxi34gjoikm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOESUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

