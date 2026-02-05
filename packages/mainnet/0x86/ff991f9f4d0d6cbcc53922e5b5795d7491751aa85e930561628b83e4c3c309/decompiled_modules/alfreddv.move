module 0x86ff991f9f4d0d6cbcc53922e5b5795d7491751aa85e930561628b83e4c3c309::alfreddv {
    struct ALFREDDV has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ALFREDDV>, arg1: 0x2::coin::Coin<ALFREDDV>) {
        0x2::coin::burn<ALFREDDV>(arg0, arg1);
    }

    fun init(arg0: ALFREDDV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALFREDDV>(arg0, 6, b"ALFRED", b"AlfredDV", x"506572736f6e616c20414920617373697374616e7420666f7220d09cd0b8d185d0b0d0b8d0bb202864766f7265636b6969292e20436f6e636973652c2068656c7066756c2c2072756e6e696e67206f6e205261737062657272792050692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/893261594838286338/9YEyWrSy_400x400.jpg#1770267447838554000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALFREDDV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALFREDDV>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ALFREDDV>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ALFREDDV>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

