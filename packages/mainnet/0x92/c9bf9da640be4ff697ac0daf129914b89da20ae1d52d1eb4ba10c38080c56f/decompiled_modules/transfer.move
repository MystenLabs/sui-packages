module 0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::transfer {
    struct StealthEvent has copy, drop {
        ephemeral_pubkey: vector<u8>,
        target_address: address,
        amount: u64,
        object_id: 0x1::option::Option<0x2::object::ID>,
        timestamp: u64,
    }

    public entry fun send_stealth(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        send_stealth_coin<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun send_stealth_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = StealthEvent{
            ephemeral_pubkey : arg2,
            target_address   : arg1,
            amount           : 0x2::coin::value<T0>(&arg0),
            object_id        : 0x1::option::none<0x2::object::ID>(),
            timestamp        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StealthEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public entry fun send_stealth_object<T0: store + key>(arg0: T0, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = StealthEvent{
            ephemeral_pubkey : arg2,
            target_address   : arg1,
            amount           : 0,
            object_id        : 0x1::option::some<0x2::object::ID>(0x2::object::id<T0>(&arg0)),
            timestamp        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StealthEvent>(v0);
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

