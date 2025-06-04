module 0x1225da0f25edbd549e469af9f6b28d9259a52fb65c2f8a8287957a1197c8f9bd::say {
    struct SAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAY>(arg0, 6, b"SAY", b"Sui aped you", b"Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihaol4cucihdzjuqv5gszkoio5e4w637waxkzntsyck7hmj264yju")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

