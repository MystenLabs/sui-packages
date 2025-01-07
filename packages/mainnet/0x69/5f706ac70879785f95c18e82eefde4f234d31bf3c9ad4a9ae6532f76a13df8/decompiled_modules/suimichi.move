module 0x695f706ac70879785f95c18e82eefde4f234d31bf3c9ad4a9ae6532f76a13df8::suimichi {
    struct SUIMICHI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIMICHI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIMICHI>>(0x2::coin::mint<SUIMICHI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUIMICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMICHI>(arg0, 9, b"SMICHI", b"SUIMICHI", b"cat memes are destine to take over the era of dogs is gone long live suimichi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1861428464508915712/F7EEMzh0_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMICHI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMICHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMICHI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

