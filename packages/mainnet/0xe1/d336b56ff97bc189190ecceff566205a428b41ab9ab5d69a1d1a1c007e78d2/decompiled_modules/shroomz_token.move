module 0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::shroomz_token {
    struct SHROOMZ_TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHROOMZ_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHROOMZ_TOKEN>>(0x2::coin::mint<SHROOMZ_TOKEN>(arg0, arg1, arg3), arg2);
    }

    public fun decimals() : u8 {
        9
    }

    fun init(arg0: SHROOMZ_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHROOMZ_TOKEN>(arg0, 9, b"SHROOMZ", b"Shroomz Token", b"Magical mushroom farming token on Sui blockchain. Grow mystical mushrooms and earn rewards in the enchanted realm of Shroomz.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://shroomz.fun/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHROOMZ_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHROOMZ_TOKEN>>(v1);
    }

    public fun name() : vector<u8> {
        b"Shroomz Token"
    }

    public fun symbol() : vector<u8> {
        b"SHROOMZ"
    }

    // decompiled from Move bytecode v6
}

