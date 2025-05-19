module 0x9969588f44fc268e19465aad9490411d667a90eccb69ab2d69f43a640d4e8545::dbp {
    struct DBP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBP>(arg0, 6, b"DBP", b"Dont Buy Pokemon", x"446f6e277420627579207468697320506f6bc3a96d6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic76xpnhbl5uy6gbvb4la26gmqj4dvyrhrc4quxbakuautpkho6ke")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DBP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

