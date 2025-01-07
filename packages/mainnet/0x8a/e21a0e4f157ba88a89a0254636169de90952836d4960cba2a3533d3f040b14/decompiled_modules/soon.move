module 0x8ae21a0e4f157ba88a89a0254636169de90952836d4960cba2a3533d3f040b14::soon {
    struct SOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOON>(arg0, 9, b"SOON", b"SOON", b"Something majestic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.mds.yandex.net/i?id=406c864725127caab54d12d9950fa8b5_l-4828150-images-thumbs&ref=rim&n=13&w=640&h=640")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

