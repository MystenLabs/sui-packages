module 0x222a99ce91c43f3c91e31ce56e78bcb914a7421754ef2b637f9ccef2f23a0013::GOW {
    struct GOW has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GOW>, arg1: 0x2::coin::Coin<GOW>) {
        0x2::coin::burn<GOW>(arg0, arg1);
    }

    fun init(arg0: GOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOW>(arg0, 9, b"GOW", b"GOW Of War", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/6N5y0hc/GOW.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GOW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

