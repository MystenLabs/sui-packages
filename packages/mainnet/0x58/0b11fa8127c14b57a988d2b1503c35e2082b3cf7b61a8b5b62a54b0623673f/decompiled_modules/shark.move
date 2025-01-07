module 0x580b11fa8127c14b57a988d2b1503c35e2082b3cf7b61a8b5b62a54b0623673f::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 9, b"SHARK", b"Bored Shark", b"Bored Shark on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/Qmc9eJiiWAhyNCDpo7wQ9uPyD3tBYSSSan6dvJeAHZ38fG"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARK>>(v1);
        0x2::coin::mint_and_transfer<SHARK>(&mut v2, 1000000000000000000, @0xa412972267c72069b0a97081e6b4c23c75297b8f25062a8643b06dd7e37310b8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHARK>>(v2);
    }

    // decompiled from Move bytecode v6
}

