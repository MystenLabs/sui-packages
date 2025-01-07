module 0xe55aad800d1276153eb0f5ecff1d04b3d98646e079a203fabccf4c43d95cba3e::suijob {
    struct SUIJOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJOB>(arg0, 6, b"SUIJOB", b"SUI JOB", b"SUIJOB is a decentralized digital currency inspired by the hit Netflix series. Join the conspiracy and become part of the underground world where nothing is as it seems. This meme coin aims to build a strong community of fans and crypto enthusiasts, sharing in the humor and intrigue of the show.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tokenomics_reagan_bee365bff1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

