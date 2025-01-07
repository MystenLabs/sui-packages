module 0x58e0f4daaaba348da43553ab7c41901dbd5c0f693c80a5f7b55490eb93a60bb8::bongo {
    struct BONGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONGO>(arg0, 9, b"BONGO", b"Bongo", b"Bonbo is a token on the Sui blockchain, designed for fast and secure transactions with low fees. It aims to power decentralized ecosystems and foster community growth within the blockchain space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1211248850356228096/FdEzVlPW.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BONGO>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

