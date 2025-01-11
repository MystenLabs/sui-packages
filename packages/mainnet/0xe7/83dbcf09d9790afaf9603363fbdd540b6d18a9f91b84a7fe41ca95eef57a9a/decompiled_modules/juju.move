module 0xe783dbcf09d9790afaf9603363fbdd540b6d18a9f91b84a7fe41ca95eef57a9a::juju {
    struct JUJU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUJU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUJU>(arg0, 9, b"JUJU", b"JUJU", b"juju love you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1875877421272244224/RJVeH9hx_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUJU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUJU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUJU>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

