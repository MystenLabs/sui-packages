module 0xb37dbe5b949c9898fe78b9f95e4d591b359804367aebf5d81965ff5b0a85b5e2::SPEPA {
    struct SPEPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPA>(arg0, 9, b"SPEPA", b"SUI SPEPA", b"SUI SPEPA, building the most vibrant memecoin community of SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1750444640757800960/DAWofhYu_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPEPA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPEPA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

