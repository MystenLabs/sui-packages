module 0xafb3581303991d256671b0c52213553e72c4b0278288b1739a62b7997479daac::suinami {
    struct SUINAMI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUINAMI>, arg1: 0x2::coin::Coin<SUINAMI>) {
        0x2::coin::burn<SUINAMI>(arg0, arg1);
    }

    fun init(arg0: SUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMI>(arg0, 9, b"SUINAMI", b"SUINAMI", b"shuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYKRPnNSzu2nBo3vXTL7r1WxG7RTuWQa7Xj1z6vSUN2YU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINAMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUINAMI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUINAMI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

