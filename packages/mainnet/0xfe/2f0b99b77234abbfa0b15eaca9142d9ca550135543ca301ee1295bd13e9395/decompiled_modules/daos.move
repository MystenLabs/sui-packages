module 0xfe2f0b99b77234abbfa0b15eaca9142d9ca550135543ca301ee1295bd13e9395::daos {
    struct DAOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAOS>(arg0, 9, b"DAOS", b"Daossui Token", b"$DAOS is the governance token of daos.sui, the first DAO Fund on the Sui blockchain. Designed to empower the community, daos.sui enables the creation and management of decentralized hedge funds. As the backbone of the platform, $DAOS drives and sustains its operations, ensuring seamless functionality and community-driven growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public.daossui.io/dao-sui/assets/daossui-token.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DAOS>>(0x2::coin::mint<DAOS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DAOS>>(v2);
    }

    // decompiled from Move bytecode v6
}

