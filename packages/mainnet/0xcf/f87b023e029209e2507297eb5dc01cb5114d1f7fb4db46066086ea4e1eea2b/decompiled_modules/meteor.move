module 0xcff87b023e029209e2507297eb5dc01cb5114d1f7fb4db46066086ea4e1eea2b::meteor {
    struct METEOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: METEOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METEOR>(arg0, 9, b"METEOR", b"Meteor", b"Meteor Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.mds.yandex.net/i?id=987dd96b3ae2bd1e42ef74d187c493e2_l-5447622-images-thumbs&n=13")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<METEOR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METEOR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<METEOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

