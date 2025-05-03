module 0x8a51036977a1149620419c492a5af8c276fdb23cf3007882909a3e0d43593654::squirtle {
    struct SQUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 751 || 0x2::tx_context::epoch(arg1) == 752, 1);
        let (v0, v1) = 0x2::coin::create_currency<SQUIRTLE>(arg0, 9, b"SQUIRT", b"SQUIRTLE", b"SUI moves like water. Squirt is water. It's a perfect overlap: velocity, flexibility, power under pressure. $SQUIRT is a signal. A shell-shocked, shade-wearing surge toward a new frontier.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmanjUwujyjMFhinXp7MxADrTTu9JnN965QpYefp6YzzvC"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUIRTLE>(&mut v2, 1000000000000000000, @0xe4f7f0dd0c90d0425b424caf6f41e6c5ccc2a0e19de66b53b246ec2e4a52ff1c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRTLE>>(v2, @0xe4f7f0dd0c90d0425b424caf6f41e6c5ccc2a0e19de66b53b246ec2e4a52ff1c);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUIRTLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

