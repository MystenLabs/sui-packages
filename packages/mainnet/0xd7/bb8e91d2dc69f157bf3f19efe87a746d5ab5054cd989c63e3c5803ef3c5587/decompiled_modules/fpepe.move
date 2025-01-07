module 0xd7bb8e91d2dc69f157bf3f19efe87a746d5ab5054cd989c63e3c5803ef3c5587::fpepe {
    struct FPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPEPE>(arg0, 9, b"FPEPE", b"Pepe Flood", b"Pepe Flood is an unstoppable wave of meme power, surging through the crypto waters with humor and strength, making a splash in the blockchain world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1654363964405424129/DyReC_gT.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FPEPE>(&mut v2, 1200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

