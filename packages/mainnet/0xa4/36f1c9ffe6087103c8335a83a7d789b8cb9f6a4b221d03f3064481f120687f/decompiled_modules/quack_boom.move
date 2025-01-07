module 0xa436f1c9ffe6087103c8335a83a7d789b8cb9f6a4b221d03f3064481f120687f::quack_boom {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<QUACK_BOOM>,
    }

    struct QUACK_BOOM has drop {
        dummy_field: bool,
    }

    struct QuackBoom has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<QUACK_BOOM>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<QUACK_BOOM>, arg1: 0x2::coin::Coin<QUACK_BOOM>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::balance::value<QUACK_BOOM>(0x2::coin::balance<QUACK_BOOM>(&arg1)) >= arg2, 0);
        0x2::coin::burn<QUACK_BOOM>(arg0, arg1)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<QUACK_BOOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QUACK_BOOM>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: QUACK_BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACK_BOOM>(arg0, 9, b"QBOOM", b"QuackBoom", b"QuackBoom is a fun token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://utfs.io/f/twuH73scZrUEt20HkNscZrUE2QgyfOAPwJsn6uzW5SpBbCMo"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUACK_BOOM>>(v1);
        0x2::coin::mint_and_transfer<QUACK_BOOM>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACK_BOOM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

