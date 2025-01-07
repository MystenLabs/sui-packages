module 0xedfae171215baf498bbccbacece387e2d181f75941f020a828191d2338f5ae3e::floxy {
    struct FLOXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOXY>(arg0, 9, b"FLOXY", b"Floxy", b"Floxy is a fast, flexible token on the Sui blockchain, designed for seamless transactions and minimal fees. It powers decentralized apps, peer-to-peer exchanges, and micro-transactions, offering speed and security for the future of Web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845904678220959744/uS0CuivZ.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLOXY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOXY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

