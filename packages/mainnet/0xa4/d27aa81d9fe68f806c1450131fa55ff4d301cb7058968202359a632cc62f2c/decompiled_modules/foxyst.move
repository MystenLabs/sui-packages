module 0xa4d27aa81d9fe68f806c1450131fa55ff4d301cb7058968202359a632cc62f2c::foxyst {
    struct FOXYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXYST>(arg0, 9, b"FOXYST", b"Fox Society Token", b"Fox Around The Den", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeigi7h5tnysermxjvwdukwivrm3mtd7wms6iomdcdty2o5h7oukpyy.ipfs.dweb.link/fox_society_token.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOXYST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXYST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXYST>>(v1);
    }

    // decompiled from Move bytecode v6
}

