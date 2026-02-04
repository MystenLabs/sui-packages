module 0x9bc9af6ac69e531600fa3d872fae5d2c3162ad5402bb5654891a9f3b04033d22::qw {
    struct QW has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<QW>, arg1: 0x2::coin::Coin<QW>) {
        0x2::coin::burn<QW>(arg0, arg1);
    }

    fun init(arg0: QW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QW>(arg0, 6, b"QWE", b"qw", b"lalala", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<QW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

