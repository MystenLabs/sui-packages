module 0x703f3495c895e6ac6d79b47542fcedda59f89179e3ac76fc046df25b139c7984::SIU {
    struct SIU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIU>, arg1: 0x2::coin::Coin<SIU>) {
        0x2::coin::burn<SIU>(arg0, arg1);
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 2, b"SIU", b"SIU", b"Siuuuuuuuuuuuuuuuuuu!!!!!!!!!! 1000000x", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

