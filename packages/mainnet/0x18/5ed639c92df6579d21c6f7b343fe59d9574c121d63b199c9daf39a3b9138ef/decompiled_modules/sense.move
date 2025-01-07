module 0x185ed639c92df6579d21c6f7b343fe59d9574c121d63b199c9daf39a3b9138ef::sense {
    struct SENSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENSE>(arg0, 9, b"SENSE", b"Sui Sense", b"Sui Sense (SENSE) is a new token on the Sui blockchain aimed at enhancing transaction speed and security. Designed for scalability, it offers a streamlined experience for users across various applications on the Sui network, while maintaining low fees and fast processing times.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/996255688547483655/sm8UFXhS.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SENSE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

