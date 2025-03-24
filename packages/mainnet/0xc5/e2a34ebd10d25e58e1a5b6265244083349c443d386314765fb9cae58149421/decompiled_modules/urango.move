module 0xc5e2a34ebd10d25e58e1a5b6265244083349c443d386314765fb9cae58149421::urango {
    struct URANGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: URANGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URANGO>(arg0, 9, b"Urango", b"TAN", b"Description: Unchain haven for me. Twitter: https://x.com/xhash, Website: https://urango.com, Telegram: https://t.me/tg_gooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihlwhhnezzp5crm2rhaksxtzxkfgc6gbkjz76seipklsvsyt3griq")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<URANGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URANGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<URANGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<URANGO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

