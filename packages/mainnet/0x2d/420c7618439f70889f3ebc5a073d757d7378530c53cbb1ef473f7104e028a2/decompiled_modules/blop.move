module 0x2d420c7618439f70889f3ebc5a073d757d7378530c53cbb1ef473f7104e028a2::blop {
    struct BLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOP>(arg0, 6, b"BLOP", b"Blobbu Sui", b"Blobbu the Cutest Jellyfish Pirate Sailing Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiewvgwj2akc3ini2fnyzyncaem4ccqaplpqi7f55l3wpcixnit5k4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

