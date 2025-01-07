module 0x1168ae5a34b68fad7a58b0b2dc1514b44f0cd9cd51ffa5a8032b9e7fadbe616f::drug {
    struct DRUG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DRUG>, arg1: 0x2::coin::Coin<DRUG>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRUG>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DRUG>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: DRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRUG>(arg0, 6, b"DrugLord", b"DRUG", x"436c69636b20746865206c696e6b20746f207374617274206561726e696e672061206461696c7920696e636f6d65207768696c6520706c6179696e6720616e206f6e2d636861696e2069646c652067616d6520f09f91872020202068747470733a2f2f647275676c6f72642e696f20202068747470733a2f2f782e636f6d2f647275676c6f72646f6e7375692068747470733a2f2f742e6d652f647275676c6f7264737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmbKfgJ4o4gjFe41ePhVoKXrskqXRPZodcd2Y4iCFC2VHU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DRUG>, arg1: 0x2::coin::Coin<DRUG>) : u64 {
        0x2::coin::burn<DRUG>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<DRUG>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DRUG> {
        0x2::coin::mint<DRUG>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

