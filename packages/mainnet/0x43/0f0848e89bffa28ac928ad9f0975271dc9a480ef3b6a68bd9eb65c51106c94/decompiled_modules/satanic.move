module 0x430f0848e89bffa28ac928ad9f0975271dc9a480ef3b6a68bd9eb65c51106c94::satanic {
    struct SATANIC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SATANIC>, arg1: 0x2::coin::Coin<SATANIC>) {
        0x2::coin::burn<SATANIC>(arg0, arg1);
    }

    fun init(arg0: SATANIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATANIC>(arg0, 6, b"SATANIC", b"SATANIC TOKEN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATANIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATANIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SATANIC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SATANIC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

