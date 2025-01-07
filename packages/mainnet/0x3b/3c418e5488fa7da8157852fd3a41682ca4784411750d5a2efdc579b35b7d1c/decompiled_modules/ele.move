module 0x3b3c418e5488fa7da8157852fd3a41682ca4784411750d5a2efdc579b35b7d1c::ele {
    struct ELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELE>(arg0, 6, b"ELE", b"Elephant", b"In a vibrant jungle, Ella the elephant found a lost bird with a broken wing. She gently carried it to the wise owl, who helped heal the bird. Grateful, the bird promised to always sing for Ella, filling the jungle with music.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSVwGwdbytapD7msz4DMmNjPYV5MTFd2J1d5KZ9wPf1DY/elephant.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELE>>(v2, @0xb64d6f8b87fa637030ff5ae3e17779e2bfeddd849985a8794ce97846762a499e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELE>>(v1);
    }

    // decompiled from Move bytecode v6
}

