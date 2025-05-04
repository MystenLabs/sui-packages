module 0xeb3df72a9cd59220bac70d55b5f53e82cb247e8015777ada71506e55a670cfe7::bulbasui {
    struct BULBASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULBASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULBASUI>(arg0, 9, b"BULBASUI", b"BulbaSUI", b"Plant/seed inspired token growing on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieepakb7sao4wzlsce7bvdns4u7c3op66kv3daw5acz6rii6rp3vq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULBASUI>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULBASUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULBASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

