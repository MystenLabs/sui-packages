module 0xe2de0faf9e82d7525a1947b6bee615a3dc02339bcabe615595237855220efef3::fock {
    struct FOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOCK>(arg0, 6, b"FOCK", b"FOCKING MARKET", b"The markets trash, but were still doing our thing. Everyone's chasing numbers, but were out here chasing vibes. So why dont you stay and FOCK around and find out with us? ;D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp2_803631cc7d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

