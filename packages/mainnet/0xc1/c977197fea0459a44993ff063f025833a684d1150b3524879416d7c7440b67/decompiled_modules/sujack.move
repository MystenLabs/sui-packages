module 0xc1c977197fea0459a44993ff063f025833a684d1150b3524879416d7c7440b67::sujack {
    struct SUJACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUJACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUJACK>(arg0, 9, b"SUJACK", b"SUJACK", b"Only way is higher", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1744077708538097665/E4CYyh1y.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUJACK>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUJACK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUJACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

