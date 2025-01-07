module 0x7f0d3a990181a891c0d53933ccf114d3ea5308d95de72e51158f152c7717fb5b::vdance {
    struct VDANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDANCE>(arg0, 9, b"VDANCE", b"VictoryDance", b"VictoryDance is a token centered around celebrating electoral success and fostering community-driven change. Holders can engage in token-based campaigns, cast votes to influence key initiatives, and celebrate milestones with unique rewards. Designed to bring unity and empowerment, VictoryDance connects the spirit of democratic participation with blockchain innovation, creating a vibrant space for collaborative governance and achievement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1803656552718725120/PmPVE3gn.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VDANCE>(&mut v2, 700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDANCE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VDANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

