module 0x30744f46827de2c15de4a2b1d972cb86f9cfef31eb49a52ef3086df5f775e35::transfer {
    struct StealthEvent has copy, drop {
        ephemeral_pubkey: vector<u8>,
        amount: u64,
        timestamp: u64,
    }

    public entry fun send_stealth(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = StealthEvent{
            ephemeral_pubkey : arg2,
            amount           : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            timestamp        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StealthEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

