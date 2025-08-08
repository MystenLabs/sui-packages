module 0x2b69ab9815ca348b3b190c826f5efdff66260d808b3bc509ee42b77522f1961::asdfd {
    struct ASDFD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ASDFD>, arg1: 0x2::coin::Coin<ASDFD>) {
        0x2::coin::burn<ASDFD>(arg0, arg1);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<ASDFD>) : u64 {
        0x2::coin::total_supply<ASDFD>(arg0)
    }

    public fun balance(arg0: &0x2::coin::Coin<ASDFD>) : u64 {
        0x2::coin::value<ASDFD>(arg0)
    }

    fun init(arg0: ASDFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDFD>(arg0, 9, b"ASDFD", b"bkah blagh", b"nndfdsf dsfsdfsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dropkit.com/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASDFD>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASDFD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::coin::mint_and_transfer<ASDFD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

