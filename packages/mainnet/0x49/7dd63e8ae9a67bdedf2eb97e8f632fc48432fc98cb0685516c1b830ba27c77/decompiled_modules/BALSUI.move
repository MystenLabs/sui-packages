module 0x497dd63e8ae9a67bdedf2eb97e8f632fc48432fc98cb0685516c1b830ba27c77::BALSUI {
    struct BALSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALSUI>(arg0, 6, b"Bali Sui", b"BALSUI", b"Bali Sui is the ultimate meme coin inspired by the tropical paradise of Bali. It combines the laid-back island vibes with the unstoppable energy of crypto. Whether you're hodling by the beach or surfing the market waves, BALSUI is your ticket to a decentralized island getaway!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafybeic57cpmgmebvssnjqt4c5673bzy56pysu3pzi3o5b3oly7s6qutpq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALSUI>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

