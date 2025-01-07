module 0x2bd412d3cd67ced1d95f08cd89b942bbabdec7b50008912f0cf9eee814c56a32::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 9, b"SHARK", b"Bored Shark", b"Bored Shark on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/Qmc9eJiiWAhyNCDpo7wQ9uPyD3tBYSSSan6dvJeAHZ38fG"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARK>>(v1);
        0x2::coin::mint_and_transfer<SHARK>(&mut v2, 1000000000000000000, @0xd1a3c6c2f2e4081880528be3290bcf95c2dc83b5c06af8610196bfba5d5180fa, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHARK>>(v2);
    }

    // decompiled from Move bytecode v6
}

