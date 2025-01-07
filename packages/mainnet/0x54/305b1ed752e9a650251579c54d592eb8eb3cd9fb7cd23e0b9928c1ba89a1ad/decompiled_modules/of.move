module 0x54305b1ed752e9a650251579c54d592eb8eb3cd9fb7cd23e0b9928c1ba89a1ad::of {
    struct OF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OF>(arg0, 9, b"OF", b"OnlyFans", b"OnlyFans in the Metaverse check out our web/metaverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdJY3ZBev565zdEbTaxG6yCCo2ynxynVE8a38NGBvECwQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

