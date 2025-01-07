module 0xa560154938d974b71ac4fce312b8b1e7e20340b6d4e6398424be41df261c84f0::zitz {
    struct ZITZ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZITZ>, arg1: 0x2::coin::Coin<ZITZ>) {
        0x2::coin::burn<ZITZ>(arg0, arg1);
    }

    fun init(arg0: ZITZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZITZ>(arg0, 9, b"zitz", b"ztz", b"A Leap Towards Prosperity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/WBqo4Zw.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZITZ>>(v1);
        0x2::coin::mint_and_transfer<ZITZ>(&mut v2, 3000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZITZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZITZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZITZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

