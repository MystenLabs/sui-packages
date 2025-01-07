module 0x1cbbefc342049f5af00ce45a13a98764f835443c5979928a327a2399bcac3651::XIAO {
    struct XIAO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XIAO>, arg1: 0x2::coin::Coin<XIAO>) {
        0x2::coin::burn<XIAO>(arg0, arg1);
    }

    fun init(arg0: XIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIAO>(arg0, 9, b"XIAO", b"XIAO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/k1L14n2/xiao.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XIAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XIAO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XIAO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

