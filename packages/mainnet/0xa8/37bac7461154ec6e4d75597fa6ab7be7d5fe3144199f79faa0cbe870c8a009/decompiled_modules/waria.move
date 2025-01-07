module 0xa837bac7461154ec6e4d75597fa6ab7be7d5fe3144199f79faa0cbe870c8a009::waria {
    struct WARIA has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"WARIA", b"WARIA SUI LOVE", b"WARIA IS THE SUI LOVE SYMBOL OF SUUUUUUUUWEEEEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wallpapers-clan.com/wp-content/uploads/2024/03/mario-pfp-29.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    public entry fun confirm(arg0: &mut 0x2::coin::TreasuryCap<WARIA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WARIA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WARIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<WARIA>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

