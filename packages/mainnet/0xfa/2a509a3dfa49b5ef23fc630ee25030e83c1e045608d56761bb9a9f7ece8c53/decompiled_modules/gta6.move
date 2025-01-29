module 0xfa2a509a3dfa49b5ef23fc630ee25030e83c1e045608d56761bb9a9f7ece8c53::gta6 {
    struct GTA6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTA6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTA6>(arg0, 9, b"GTA6", b"GTA 6 Coin", b"GTA 6 Coin launched on sui after Rockstar announced that cryptocurrencies will be present in the game scheduled for December 2025.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdJajwBkrXwv3RH92n3sMJLHLpSHAZTWBUtw9vQNb6iA8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GTA6>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTA6>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTA6>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

