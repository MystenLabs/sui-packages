module 0x977662275ee428e02faf6a9be6a6bd4e8794550a96b33415bcb0716ef73a0900::node {
    struct NODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NODE>(arg0, 6, b"NODE", b"NodeBook", b"This token serves as a decentralized phone book, enabling secure and private contact management on the blockchain. Easily store, share, and access verified contact information while in full control of your data in a tamper-proof, trustless network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734981379610.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NODE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NODE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

