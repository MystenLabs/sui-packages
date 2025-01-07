module 0xc70f2ce7dbf47598f4adf8dbd8fcb5ab93b45b149ebd494c8494e7e941b8aa16::causa {
    struct CAUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAUSA>(arg0, 9, b"CAUSA", b"Causa Sui", b"Ex Unitae Vires - Ens Causa Sui   https://app.releap.xyz/profile/0x59d77f25918a3b0a54c804df3c865ccab859d6abe1674f0ba89a63e5478cbc69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/ZJj_zTQd8UsSQQdH-8NdeKKNOK7BJDCKEfSGQ0bLUT0?ext=jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAUSA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAUSA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

