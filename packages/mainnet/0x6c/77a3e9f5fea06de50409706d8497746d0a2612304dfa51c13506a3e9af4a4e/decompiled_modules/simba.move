module 0x6c77a3e9f5fea06de50409706d8497746d0a2612304dfa51c13506a3e9af4a4e::simba {
    struct SIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMBA>(arg0, 6, b"Simba", b"Simba on SUI", b"Simba on ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x5d6881b68371f1d801ad93fb40d1cb130dd1975717170190207651b701938b72_simba_simba_df0c461a55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

