module 0xe6e292e2e55a18480863c13af0bf3d536f0b1926deddd17a17dd0810a15236c::tauros {
    struct TAUROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAUROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAUROS>(arg0, 6, b"TAUROS", b"TAURSUI", x"43686172676520666f7277617264207769746820546175726f732c2074686520756e73746f707061626c6520666f726365206f6e207468652053756920626c6f636b636861696e2120496e73706972656420627920746865206c6567656e6461727920506f6bc3a96d6f6e20546175726f7320616e642074686520737069726974206f662061206d61726b65742062756c6c2072756e2c206f75722070726f6a656374206973206275696c7420666f722073706565642c20706f7765722c20616e642067726f7774682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreici6vepar2vyhl4indtj2qt722t3akogcfwjeysyhu5yo63mlneg4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAUROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAUROS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

