module 0xaa5f0a915d8f16cad9bf61232fa1512017623409e41765d74a15adf7912c2217::suickk {
    struct SUICKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICKK>(arg0, 9, b"SUICKK", b"SUICKK", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICKK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICKK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

