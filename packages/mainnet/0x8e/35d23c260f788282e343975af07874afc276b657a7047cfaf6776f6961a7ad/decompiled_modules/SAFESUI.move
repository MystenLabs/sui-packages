module 0x8e35d23c260f788282e343975af07874afc276b657a7047cfaf6776f6961a7ad::SAFESUI {
    struct SAFESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFESUI>(arg0, 9, b"SafeSui", b"Safe Sui", b"Sui Builder, building blockchain, commerce, metaverse and NFT products to derive new kinds of value from crypto technology and to apply it to increasingly better use. Advancing our innovations to every part of the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/RaeY3TQ.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAFESUI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAFESUI>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SAFESUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

