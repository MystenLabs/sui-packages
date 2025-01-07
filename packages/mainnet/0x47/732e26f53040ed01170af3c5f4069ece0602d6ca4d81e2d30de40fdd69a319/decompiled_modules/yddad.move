module 0x47732e26f53040ed01170af3c5f4069ece0602d6ca4d81e2d30de40fdd69a319::yddad {
    struct YDDAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: YDDAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YDDAD>(arg0, 9, b"YDDAD", b"PaffDaddyParty", b"PaffDaddyParty is a lively, community-focused token on the SUI blockchain, offering fast, secure transactions. It combines fun and innovation, making DeFi accessible and exciting for all users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1782328082894057472/3zprdxbT.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YDDAD>(&mut v2, 225000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YDDAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YDDAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

