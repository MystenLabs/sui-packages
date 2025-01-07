module 0x56aa67b23279b603d161b6084905671d6670784ec82f811ebc6046d4602ef974::bag {
    struct BAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAG>(arg0, 9, b"BAG", b"MOONBAG", b"Bag To The MOON!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.nationalgeographic.org/image/upload/t_edhub_resource_key_image/v1638887460/EducationHub/photos/full-moon.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BAG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

