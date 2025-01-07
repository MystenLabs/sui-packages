module 0x11132a77c2aa350269352ea2cbcf9793bcb760e593fe2407aa231a5316d5346f::moki {
    struct MOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKI>(arg0, 6, b"Moki", b"Mokimeme", b"Welcome to SuiMoki ($MOKI), where the thrill of the ride meets the excitement of cryptocurrency. MokiMeme brings a unique fusion of high-octane action and cutting-edge digital finance. Whether you're an adrenaline junkie or a crypto enthusiast, $MOKI is your ticket to a world where cars collide, fortunes are made, and the arena is always buzzing with the next BIG WIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037324_33ccb2a2e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

