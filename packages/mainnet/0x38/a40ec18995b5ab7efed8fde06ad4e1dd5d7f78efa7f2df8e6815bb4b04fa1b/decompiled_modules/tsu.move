module 0x38a40ec18995b5ab7efed8fde06ad4e1dd5d7f78efa7f2df8e6815bb4b04fa1b::tsu {
    struct TSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSU>(arg0, 6, b"TSU", b"CAPTAIN TSUBASA", b"Captain Tsubasa on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreian2krmet72armacsbqj2m4rxmt5esypyjohfou772lv2eootshte")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

