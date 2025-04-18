module 0xeca427a7dab51568199264aaee43ba3f1d38dbd556d99852bbce72d5e6e43d53::zsr {
    struct ZSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZSR>(arg0, 9, b"ZSR", b"Zitro Solaire", b"Zitro Solar (ZSR) is a pioneering cryptocurrency token designed to revolutionize renewable energy investments and solar power adoption. As a digital asset tied directly to the growth of sustainable energy,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"file:///C:/Users/ortiz/OneDrive/Desktop/Edwin%20Folder/sun-power.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZSR>(&mut v2, 250000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZSR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

