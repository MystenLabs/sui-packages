module 0x2e3759b535527886faf5e57e03cc47a75b692c2dfaf9a34974e2629f31472770::insidejob {
    struct INSIDEJOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSIDEJOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSIDEJOB>(arg0, 6, b"INSIDEJOB", b"INSIDEJOB SUI", b"Inside Job Sui is a decentralized digital currency inspired by the hit Netflix series. Join the conspiracy and become part of the underground world where nothing is as it seems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tokenomics_reagan_8fe1f35a25.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSIDEJOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INSIDEJOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

