module 0xb77ae1c2e921012997829d5ccaab41b6530472f3efba3dd448c7b55ea17dcbc::stink {
    struct STINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STINK>(arg0, 6, b"STINK", b"GarlicSui", b"GarlicSui STINK is a community powered meme token built on the Sui blockchain. Led by our bold mascot STINKY, an anthropomorphic garlic bulb with attitude, GarlicSui detects the stink of bear markets before they hit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibkjcg46txw2lcubkys4n2jo4m5vkg66lkr3tt3xjbeqcazllyw6a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STINK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

