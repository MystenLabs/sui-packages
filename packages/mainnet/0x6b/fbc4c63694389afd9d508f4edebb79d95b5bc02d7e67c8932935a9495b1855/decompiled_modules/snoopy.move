module 0x6bfbc4c63694389afd9d508f4edebb79d95b5bc02d7e67c8932935a9495b1855::snoopy {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<SNOOPY>,
    }

    struct SNOOPY has drop {
        dummy_field: bool,
    }

    struct Snoopy has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<SNOOPY>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SNOOPY>, arg1: 0x2::coin::Coin<SNOOPY>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::balance::value<SNOOPY>(0x2::coin::balance<SNOOPY>(&arg1)) >= arg2, 0);
        0x2::coin::burn<SNOOPY>(arg0, arg1)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SNOOPY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SNOOPY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SNOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOPY>(arg0, 9, b"SNP", b"SNOOPY", b"Snoopy is meme of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://https://utfs.io/f/twuH73scZrUE39t7nvpMafgjxvuliYGzkLdQP5r0oFSV68nM"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNOOPY>>(v1);
        0x2::coin::mint_and_transfer<SNOOPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOPY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

