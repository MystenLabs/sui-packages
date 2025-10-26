module 0x86bfe4f462df9206517046c0449a933cdb7c4f1447254e669f37214d7a772d67::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUN>, arg1: 0x2::coin::Coin<SUN>) {
        0x2::coin::burn<SUN>(arg0, arg1);
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 9, b"SUN", b"Sunny", b"hi there:)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://postimg.cc/hJFb2bfV")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

