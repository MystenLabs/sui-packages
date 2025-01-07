module 0x8c44397a0e79ba395aebc5b9e936341b076b02dc02f5229970c204158082742a::len {
    struct LEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LEN>, arg1: 0x2::coin::Coin<LEN>) {
        0x2::coin::burn<LEN>(arg0, arg1);
    }

    fun init(arg0: LEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEN>(arg0, 9, b"LEN", b"Satoshi revealed", b"LEN 'rabbi' SASSAMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qme6evvwrYAtJ7DBQocjZeLUUs9bKdHaEUBhgB92LsfmD2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LEN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

