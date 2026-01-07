module 0x54f35b6f34a70bd26c7f23959218d1383644e92cbdc489ca9f3c217e2a343022::MSCOIN {
    struct MSCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MSCOIN>, arg1: 0x2::coin::Coin<MSCOIN>) {
        0x2::coin::burn<MSCOIN>(arg0, arg1);
    }

    fun init(arg0: MSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSCOIN>(arg0, 9, b"MAGMA", x"d09c61676dd0b020d0a26f6bd0b56e", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yellow-fascinating-hornet-971.mypinata.cloud/ipfs/bafkreihzqruw2jhz4sihh2oorwyq44cragyhngrxvprdespoguyu7vejbi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MSCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MSCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MSCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

