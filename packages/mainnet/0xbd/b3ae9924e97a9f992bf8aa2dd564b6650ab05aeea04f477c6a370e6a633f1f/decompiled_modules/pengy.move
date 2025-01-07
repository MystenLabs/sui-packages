module 0xbdb3ae9924e97a9f992bf8aa2dd564b6650ab05aeea04f477c6a370e6a633f1f::pengy {
    struct PENGY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PENGY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PENGY>>(0x2::coin::mint<PENGY>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: PENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGY>(arg0, 9, b"PENGY", b"PENGY", b"Inonic memorable, adorable, amazing and cute NFT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1848765927451492364/VysuN6mu_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENGY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

