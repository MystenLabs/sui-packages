module 0x4f27a7b4462bcebf900d6db3071364cd19cf507422de8965260481cf396359fb::msp {
    struct MSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSP>(arg0, 6, b"MSP", b"MemeSuiParty", b"Meme Sui Party ($MSP) is not just another memecoin; its a celebration of the Sui ecosystem's most iconic memecoins. We're throwing the ultimate digital party where the community can pump, party, and moon together! The entire project is themed around a wild crypto party, where the fun never", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cc_Fc_Wlr_400x400_d4cab613b0_6ed95d4db3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

