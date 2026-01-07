module 0xc8117a9f414dfac54f4c71bae40e3402ac9c587be6a16362656d3f13744775f::MGCOIN {
    struct MGCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MGCOIN>, arg1: 0x2::coin::Coin<MGCOIN>) {
        0x2::coin::burn<MGCOIN>(arg0, arg1);
    }

    fun init(arg0: MGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGCOIN>(arg0, 9, b" ", x"d09c61676dd0b020d0a26f6bd0b56e", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yellow-fascinating-hornet-971.mypinata.cloud/ipfs/bafkreihzqruw2jhz4sihh2oorwyq44cragyhngrxvprdespoguyu7vejbi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MGCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MGCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MGCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

