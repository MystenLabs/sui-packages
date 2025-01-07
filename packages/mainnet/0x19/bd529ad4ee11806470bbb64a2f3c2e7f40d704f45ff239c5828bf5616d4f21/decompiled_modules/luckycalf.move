module 0x19bd529ad4ee11806470bbb64a2f3c2e7f40d704f45ff239c5828bf5616d4f21::luckycalf {
    struct LUCKYCALF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKYCALF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKYCALF>(arg0, 6, b"LUCKYCALF", b"Lucky Calf", b"Lucky Calf is an NFT that will be released on Sui soon. Holders of $LUCKYCALF will have the opportunity to receive the Lucky Calf NFT airdrop after the NFT is released.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049744_e8a651930f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKYCALF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCKYCALF>>(v1);
    }

    // decompiled from Move bytecode v6
}

