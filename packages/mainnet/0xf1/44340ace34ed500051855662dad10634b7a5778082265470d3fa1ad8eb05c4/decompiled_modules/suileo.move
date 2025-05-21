module 0xf144340ace34ed500051855662dad10634b7a5778082265470d3fa1ad8eb05c4::suileo {
    struct SUILEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEO>(arg0, 6, b"SUILEO", b"Interleon On Sui", b"Interleon On Sui is coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie6oxesimskuzx4tmfkk4e7nmmob3tward2lwegagf6x6meqmerf4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILEO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

