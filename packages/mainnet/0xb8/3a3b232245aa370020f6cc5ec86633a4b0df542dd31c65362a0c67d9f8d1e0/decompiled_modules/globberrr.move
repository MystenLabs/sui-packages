module 0xb83a3b232245aa370020f6cc5ec86633a4b0df542dd31c65362a0c67d9f8d1e0::globberrr {
    struct GLOBBERRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOBBERRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOBBERRR>(arg0, 9, b"GLOBBERRR", b"GLOBBERRR", b"wakkkkaka", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GLOBBERRR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOBBERRR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOBBERRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

