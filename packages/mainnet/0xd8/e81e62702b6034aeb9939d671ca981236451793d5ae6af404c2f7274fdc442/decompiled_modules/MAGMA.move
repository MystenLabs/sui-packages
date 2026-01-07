module 0xd8e81e62702b6034aeb9939d671ca981236451793d5ae6af404c2f7274fdc442::MAGMA {
    struct MAGMA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MAGMA>, arg1: 0x2::coin::Coin<MAGMA>) {
        0x2::coin::burn<MAGMA>(arg0, arg1);
    }

    fun init(arg0: MAGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGMA>(arg0, 9, b"MAGMA", x"d09c61676dd0b020d0a26f6bd0b56e", b"Ecosystem coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yellow-fascinating-hornet-971.mypinata.cloud/ipfs/bafkreihzqruw2jhz4sihh2oorwyq44cragyhngrxvprdespoguyu7vejbi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAGMA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MAGMA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

