module 0x3a82dc9440b8b92d73e4bbd81f9a0816b37724ac0c45b5488c12fa5b6c6d909a::pokewob {
    struct POKEWOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEWOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEWOB>(arg0, 6, b"POKEWOB", b"POKEWOBSUI", b"Join the wobble. Reflect the chaos. Counter to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieao7ca6vmxffwan5omodlgvdad2fjnycmyecduvhtjk44kecp2le")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEWOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEWOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

