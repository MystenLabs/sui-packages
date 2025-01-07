module 0xea1cdbe236d9227e478026cead7c7ab623cac9e9728bbd3d7adfc01945fd47bf::suisabi {
    struct SUISABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISABI>(arg0, 2, b"SABI", b"SUISABI", b"The only one SUISABI on SUI, to make better your food", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/9veAyt0.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISABI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUISABI>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISABI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISABI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

