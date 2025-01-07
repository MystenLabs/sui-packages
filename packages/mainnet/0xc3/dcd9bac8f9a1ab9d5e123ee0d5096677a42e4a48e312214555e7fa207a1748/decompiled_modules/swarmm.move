module 0xc3dcd9bac8f9a1ab9d5e123ee0d5096677a42e4a48e312214555e7fa207a1748::swarmm {
    struct SWARMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARMM>(arg0, 6, b"SWARMM", b"SWARM", b"We move like a $Swarm, decentralized and leaderless ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/swarm_ef177f1b1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWARMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

