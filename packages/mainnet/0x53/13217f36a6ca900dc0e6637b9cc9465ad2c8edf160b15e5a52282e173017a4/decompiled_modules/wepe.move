module 0x5313217f36a6ca900dc0e6637b9cc9465ad2c8edf160b15e5a52282e173017a4::wepe {
    struct WEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEPE>(arg0, 9, b"WEPE", b"Water PEPE", b"https://t.me/WaterPepeSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/Bzm7cfw/st-small-507x507-pad-600x600-f8f8f8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WEPE>(&mut v2, 420000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

