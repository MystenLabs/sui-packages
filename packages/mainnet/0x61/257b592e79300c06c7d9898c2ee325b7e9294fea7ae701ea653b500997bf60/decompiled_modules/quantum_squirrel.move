module 0x61257b592e79300c06c7d9898c2ee325b7e9294fea7ae701ea653b500997bf60::quantum_squirrel {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<QUANTUM_SQUIRREL>,
    }

    struct QUANTUM_SQUIRREL has drop {
        dummy_field: bool,
    }

    struct QuantumSquirrel has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<QUANTUM_SQUIRREL>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<QUANTUM_SQUIRREL>, arg1: 0x2::coin::Coin<QUANTUM_SQUIRREL>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::balance::value<QUANTUM_SQUIRREL>(0x2::coin::balance<QUANTUM_SQUIRREL>(&arg1)) >= arg2, 0);
        0x2::coin::burn<QUANTUM_SQUIRREL>(arg0, arg1)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<QUANTUM_SQUIRREL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QUANTUM_SQUIRREL>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: QUANTUM_SQUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTUM_SQUIRREL>(arg0, 9, b"NUTZ", b"QuantumSquirrel", b"QuantumSquirrel is a fun token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://utfs.io/f/twuH73scZrUE2MjruIW4aiJsOnBcuU9dzfpLh5QoWmXPgerk"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUANTUM_SQUIRREL>>(v1);
        0x2::coin::mint_and_transfer<QUANTUM_SQUIRREL>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTUM_SQUIRREL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

