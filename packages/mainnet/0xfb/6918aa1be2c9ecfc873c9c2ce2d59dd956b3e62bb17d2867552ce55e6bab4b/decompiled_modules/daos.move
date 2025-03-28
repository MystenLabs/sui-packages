module 0xfb6918aa1be2c9ecfc873c9c2ce2d59dd956b3e62bb17d2867552ce55e6bab4b::daos {
    struct DAOS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DAOS>, arg1: 0x2::coin::Coin<DAOS>) {
        0x2::coin::burn<DAOS>(arg0, arg1);
    }

    fun init(arg0: DAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAOS>(arg0, 6, b"DAOS", b"Daossui Token", b"$DAOS is the governance token of daos.sui, the first DAO Fund on the Sui blockchain. Designed to empower the community, daos.sui enables the creation and management of decentralized hedge funds. As the backbone of the platform, $DAOS drives and sustains its operations, ensuring seamless functionality and community-driven growth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public.daossui.io/dao-sui/assets/daossui-token.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DAOS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<DAOS>(arg0) == 0, 0);
        0x2::coin::mint_and_transfer<DAOS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

