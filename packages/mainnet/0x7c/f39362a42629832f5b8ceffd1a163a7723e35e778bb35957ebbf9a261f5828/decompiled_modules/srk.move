module 0x7cf39362a42629832f5b8ceffd1a163a7723e35e778bb35957ebbf9a261f5828::srk {
    struct SRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRK>(arg0, 6, b"SRK", b"Shark", b"Shark $SHARK In the world of cryptocurrencies, where the barriers between success and failure can be as sharp as a shark's teeth, along comes Shark, a memcoin that rushes forward with the strength and determination of a predator.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240916013235_6b8bdd53a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

