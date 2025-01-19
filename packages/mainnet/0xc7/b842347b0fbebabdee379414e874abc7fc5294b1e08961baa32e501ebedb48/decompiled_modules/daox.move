module 0xc7b842347b0fbebabdee379414e874abc7fc5294b1e08961baa32e501ebedb48::daox {
    struct DAOX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DAOX>, arg1: 0x2::coin::Coin<DAOX>) {
        0x2::coin::burn<DAOX>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DAOX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DAOX>>(0x2::coin::mint<DAOX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DAOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAOX>(arg0, 6, b"DAOX", b"DAOX", b"A New Era of Onchain AI Agents @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://virtualdaos.ai/images/daox_logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

