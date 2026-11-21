module 0xaca6cdff5b63f37a39bddd265416e67b898cfadedd88ff0b3d1ebcaf97fe0c63::Nogas {
    struct NOGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOGAS>(arg0, 9, b"NOGAS", b"Nogas", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b8bba38bed7173eeb48f9556d6ab73cb0f5ef8da33fd90ed42b6372e9f600f25.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NOGAS>>(0x2::coin::mint<NOGAS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOGAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOGAS>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

