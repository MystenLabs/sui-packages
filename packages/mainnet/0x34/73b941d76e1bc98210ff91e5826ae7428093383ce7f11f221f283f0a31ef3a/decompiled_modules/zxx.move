module 0x3473b941d76e1bc98210ff91e5826ae7428093383ce7f11f221f283f0a31ef3a::zxx {
    struct ZXX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZXX>, arg1: 0x2::coin::Coin<ZXX>) {
        0x2::coin::burn<ZXX>(arg0, arg1);
    }

    fun init(arg0: ZXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZXX>(arg0, 9, b"cute zxx", b"ZXX", b"abcd zxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/Zh8mb4W/download.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZXX>>(v1);
        0x2::coin::mint_and_transfer<ZXX>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXX>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZXX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZXX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

