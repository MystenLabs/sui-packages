module 0x6e549d6c86cc24006a803a06f72629c948bc01f484d7cff8f5078578a29c2618::anonymous {
    struct ANONYMOUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANONYMOUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANONYMOUS>(arg0, 6, b"ANONYMOUS", b"Sui Anonymous", b"$ANONYMOUS setting a new standard for decentralized, community-driven projects. This coin embraces the true spirit of anonymity with no official social media channels, no telegram group. The $ANONYMOUS deployer will not hold or buy any tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986821050.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANONYMOUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANONYMOUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

