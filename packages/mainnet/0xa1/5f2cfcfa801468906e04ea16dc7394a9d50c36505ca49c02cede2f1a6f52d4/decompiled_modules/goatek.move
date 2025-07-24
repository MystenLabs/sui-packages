module 0xa15f2cfcfa801468906e04ea16dc7394a9d50c36505ca49c02cede2f1a6f52d4::goatek {
    struct GOATEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATEK>(arg0, 6, b"GOATEK", b"Greatest All Of Tek", x"477265617465737420416c6c204f662054656b0a474f4154454b204953204d454e54414c495459", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeickczmhgdp4rkfhswgmreepyblkjsk6jbwouzqh7gsjckytfzdbje")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOATEK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

