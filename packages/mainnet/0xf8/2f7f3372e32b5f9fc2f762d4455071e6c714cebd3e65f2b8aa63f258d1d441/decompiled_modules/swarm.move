module 0xf82f7f3372e32b5f9fc2f762d4455071e6c714cebd3e65f2b8aa63f258d1d441::swarm {
    struct SWARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARM>(arg0, 9, b"SWARM", b"SWARM", b"Majestic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.mds.yandex.net/i?id=65853cac2835df24e99f1eb3e3dbc321_l-5239602-images-thumbs&n=13")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWARM>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

