module 0x60d0255f2771fe1d90a4b7cabc1fc7ba936f134ef471ce8785bfaeb8bad1399f::SAFESUI {
    struct SAFESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFESUI>(arg0, 9, b"SafeSui", b"Safe Sui", b"Sui Builder, building blockchain, commerce, metaverse and NFT products to derive new kinds of value from crypto technology and to apply it to increasingly better use. Advancing our innovations to every part of the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/RaeY3TQ.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAFESUI>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SAFESUI>>(v0);
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SAFESUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SAFESUI>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

