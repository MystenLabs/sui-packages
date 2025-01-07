module 0x31a26302c5a885ce3497712d04385cf7657ea60109059cb05207e1f1711366fd::suiponk {
    struct SUIPONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPONK>(arg0, 9, b"SUIPONK", b"SUIPONK", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPONK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

