module 0x8389416ec80a25f57f0a1268da549828b3e01da5166d4f6145240f4c84d83dc9::none {
    struct NONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONE>(arg0, 9, b"None", b"None", b"Number One", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://masterpiecer-images.s3.yandex.net/752c461376ff11ee9ad5ceda526c50ab:upscaled")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NONE>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

