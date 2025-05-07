module 0x94ba5c71bc98297eaec9e3c2c0d528c98a64eda7b03de1b41cddc091972604e3::bluemon {
    struct BLUEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEMON>(arg0, 6, b"BLUEMON", b"BlueMon On Sui", b"BLUEMON: SUI NETWORK  Unlikely Hero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiahekmrvvxcc3eiotiekmoy2bypfm5dcmnxhmsnkangjrjtsojxd4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

