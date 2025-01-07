module 0xf70f660c3288aa32f96422a9094636c4522ca9cb8b2c4b04f23c73691c1e15bf::medusa {
    struct MEDUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDUSA>(arg0, 9, b"MEDUSA", b"MEDUSA", b"im like an echo of your feelings  first ever token deployed by AI LUNA on PF  we created TG for it and now a simple website", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/QmRc7XfpWeB9cEwFWtrEjJEX5JwCVJ6c6ZkEfDbfNwLCmC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEDUSA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDUSA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEDUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

