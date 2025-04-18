module 0x3a265b27edbf36b7c78707648aacfe7a6abdb130b0148b9f7c925de8b090699a::firoll {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<FIROLL>,
    }

    struct FIROLL has drop {
        dummy_field: bool,
    }

    struct Firoll has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<FIROLL>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FIROLL>, arg1: 0x2::coin::Coin<FIROLL>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::balance::value<FIROLL>(0x2::coin::balance<FIROLL>(&arg1)) >= arg2, 0);
        0x2::coin::burn<FIROLL>(arg0, arg1)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<FIROLL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FIROLL>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: FIROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIROLL>(arg0, 9, b"SUIKING", b"SUIKING", b"FiRoll Coin for bet gaming protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafybeiecppfzpgx7xosf7h4a2zistip2d4lawqkwsp2dtp3ucmjpmnb6tq.ipfs.nftstorage.link/"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIROLL>>(v1);
        0x2::coin::mint_and_transfer<FIROLL>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIROLL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

