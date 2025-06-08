module 0x5627b3526fdd38cba1603b22fac01b84562fc2140fb7cddc99a8e5e590590c0f::nyla {
    struct NYLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYLA>(arg0, 6, b"NYLA", b"AgentNyla", b"Nyla: The Interactive AI Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifdngmavk5jvxic7efgezqoqu24mai3h6rz633ng2ppjxnfsyrsa4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NYLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

