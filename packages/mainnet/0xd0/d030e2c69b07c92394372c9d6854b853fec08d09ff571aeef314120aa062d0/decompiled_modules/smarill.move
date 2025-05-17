module 0xd0d030e2c69b07c92394372c9d6854b853fec08d09ff571aeef314120aa062d0::smarill {
    struct SMARILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMARILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMARILL>(arg0, 6, b"Smarill", b"Marill On Sui", b"$Smarill is the first  rewards token on SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreierelayiibmfmtnokijkq3gcg7n4cm4bxjshy74wexkpqdna6a4ee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMARILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMARILL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

