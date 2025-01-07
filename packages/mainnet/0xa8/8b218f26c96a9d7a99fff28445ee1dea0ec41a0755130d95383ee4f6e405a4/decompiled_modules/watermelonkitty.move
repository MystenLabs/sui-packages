module 0xa88b218f26c96a9d7a99fff28445ee1dea0ec41a0755130d95383ee4f6e405a4::watermelonkitty {
    struct WATERMELONKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERMELONKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERMELONKITTY>(arg0, 6, b"WATERMELONKITTY", b"Cats for Palestine", b"Listen this is not new it has been going on for over 75 years but in the last 2 years we have seen unquestionably one of the worst live broadcasted genocides in televised history. These things we usually only ever have read or watched movies about. I would like to dedicate this token to all the lives lost in Palestine human and animal, lets not forget the Zionist scum bags murder all life. This token will evolve into a project that rescues and protects cats and other animals in Palestine in anyway we can. Palestinians on the ground are doing more for the animals than any of us can but we can support those Palestinians and do what we can to ease their suffering just a little bit.I am Egyptian and have had Palestine deep in my heart since I was a boy as my father would always warn me of the zionist and their ideologies. Join our community and provide suggestions and lets see if we can find some real solutions that we can provide for this horrible situation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gb9_N8_Je_Nc_Qeoyq_Kc_Ueiq_Ksi_243bae5bd8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERMELONKITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERMELONKITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

