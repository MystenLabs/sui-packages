module 0xb815c23abe2da01d6aa67bb52667e39961e44149d0ca5b668d7720161dda0cc9::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEGEN>, arg1: 0x2::coin::Coin<DEGEN>) {
        0x2::coin::burn<DEGEN>(arg0, arg1);
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 2, b"DEGEN", b"SUI Degens Club", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreigtwm232pl7lhwbdtghtjtndehj6f3kdcx33rgbecw25bzxs3omqi.ipfs.nftstorage.link")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEGEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DEGEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

