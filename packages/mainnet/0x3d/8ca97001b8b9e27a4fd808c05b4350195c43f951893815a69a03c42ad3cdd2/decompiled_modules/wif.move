module 0x3d8ca97001b8b9e27a4fd808c05b4350195c43f951893815a69a03c42ad3cdd2::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 9, b"WIF", b"dogwifhat", b"Dogwifhat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1723823186473529344/nms-iIKi_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

