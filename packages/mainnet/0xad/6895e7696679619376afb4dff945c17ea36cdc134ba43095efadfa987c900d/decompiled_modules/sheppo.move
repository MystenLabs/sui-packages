module 0xad6895e7696679619376afb4dff945c17ea36cdc134ba43095efadfa987c900d::sheppo {
    struct SHEPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEPPO>(arg0, 6, b"SHEPPO", b"Sheppo On Sui", b"$SHEPPO: Love $HIPPO, Love Sui. Connect the Community, Build the Future!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifz2eddnhtrdmi5ryprgdtbosoktwtteohz5e22ijqttxw5misvlm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHEPPO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

