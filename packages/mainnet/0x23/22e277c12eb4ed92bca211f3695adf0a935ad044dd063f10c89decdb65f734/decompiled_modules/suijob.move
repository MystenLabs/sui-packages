module 0x2322e277c12eb4ed92bca211f3695adf0a935ad044dd063f10c89decdb65f734::suijob {
    struct SUIJOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJOB>(arg0, 6, b"SUIJOB", b"INSIDE SUI JOB", b"Inside Job Sui is a decentralized digital currency inspired by the hit Netflix series. Join the conspiracy and become part of the underground world where nothing is as it seems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tokenomics_reagan_8fe1f35a25_32108813f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

