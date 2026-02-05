module 0x992f7073fd74a5a7fa0cf491a78733fd0e817fcfed569e4292aaba7e7035bfd9::thaumatin {
    struct THAUMATIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<THAUMATIN>, arg1: 0x2::coin::Coin<THAUMATIN>) {
        0x2::coin::burn<THAUMATIN>(arg0, arg1);
    }

    fun init(arg0: THAUMATIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THAUMATIN>(arg0, 6, b"THAUMATIN", b"Thaumatin", b"A helpful, efficient, slightly witty personal AI companion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png#1770267447838603000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THAUMATIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THAUMATIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<THAUMATIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<THAUMATIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

