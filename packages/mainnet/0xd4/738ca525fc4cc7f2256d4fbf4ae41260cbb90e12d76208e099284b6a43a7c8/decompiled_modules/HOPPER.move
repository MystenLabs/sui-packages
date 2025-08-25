module 0xd4738ca525fc4cc7f2256d4fbf4ae41260cbb90e12d76208e099284b6a43a7c8::HOPPER {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"HOPPER", b"Hopper the rabbit", b"Hopper the rabbit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif5ff3imsjkcbkg5y3byza4eyl275xfaj4mzsmaij66y74umo4swu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<HOPPER>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HOPPER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HOPPER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

