module 0xb0f4bbdbed9fb11eb4d87cb8b2c331bd774908dcc1802241b0b337afc7d4a745::jazzy {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<JAZZY>,
    }

    struct JAZZY has drop {
        dummy_field: bool,
    }

    struct Jazzy has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<JAZZY>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JAZZY>, arg1: 0x2::coin::Coin<JAZZY>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::balance::value<JAZZY>(0x2::coin::balance<JAZZY>(&arg1)) >= arg2, 0);
        0x2::coin::burn<JAZZY>(arg0, arg1)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<JAZZY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JAZZY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: JAZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAZZY>(arg0, 9, b"JZZY", b"Jazzy", b"Jazzy Vibes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://utfs.io/f/twuH73scZrUEzXtSOuKpcjT4QoJ5tXVuwAqsaGZIflUhS7dH"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAZZY>>(v1);
        0x2::coin::mint_and_transfer<JAZZY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAZZY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

