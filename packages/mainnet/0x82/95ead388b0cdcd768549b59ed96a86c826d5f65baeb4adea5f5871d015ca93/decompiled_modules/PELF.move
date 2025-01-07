module 0x8295ead388b0cdcd768549b59ed96a86c826d5f65baeb4adea5f5871d015ca93::PELF {
    struct PELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELF>(arg0, 9, b"PELF", x"50454c464f525420f09f90ba", b"SUI's Community Wolf Coin, what's poppin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746700899630579712/dN9jVm1E_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PELF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELF>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PELF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PELF>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

