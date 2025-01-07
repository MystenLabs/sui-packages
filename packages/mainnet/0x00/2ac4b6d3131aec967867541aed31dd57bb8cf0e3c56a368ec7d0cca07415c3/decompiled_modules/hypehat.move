module 0x2ac4b6d3131aec967867541aed31dd57bb8cf0e3c56a368ec7d0cca07415c3::hypehat {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<HYPEHAT>,
    }

    struct HYPEHAT has drop {
        dummy_field: bool,
    }

    struct Hypehat has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<HYPEHAT>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HYPEHAT>, arg1: 0x2::coin::Coin<HYPEHAT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::balance::value<HYPEHAT>(0x2::coin::balance<HYPEHAT>(&arg1)) >= arg2, 0);
        0x2::coin::burn<HYPEHAT>(arg0, arg1)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<HYPEHAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HYPEHAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HYPEHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPEHAT>(arg0, 9, b"HYHAT", b"HYPEHAT", b"hypehat is meme of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://utfs.io/f/twuH73scZrUEXJPxXRt5YCRHEzkL7exTgry30O8lcZdb1Vvu"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPEHAT>>(v1);
        0x2::coin::mint_and_transfer<HYPEHAT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPEHAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

