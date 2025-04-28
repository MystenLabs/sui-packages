module 0xa5be6dd00741a1d2e5f8d53490310fe5ca11d4def4e9da6720a4b2321382bae8::CHIMP {
    struct CHIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIMP>(arg0, 6, b"CHIMP", b"Chimpanzini Bananini", b"Chimpanzini Bananini! wa wa wa! Bananuchi monkey monkey monkey yuchi! or Chimpanzini Cocosini? Wa wa wa! Boop boop badapim. Coconuchi monkey monkey monkey yuchi! or Chimpanzini Ananasini? wa wa wa!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmSfK9fAFYQNSbNtZmjs9fiJB5irFtYcFGTc9XqZ6z8YZ4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

