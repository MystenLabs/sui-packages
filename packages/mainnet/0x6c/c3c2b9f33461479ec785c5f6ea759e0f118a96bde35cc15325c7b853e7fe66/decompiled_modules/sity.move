module 0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity {
    struct SITY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SITY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SITY>>(0x2::coin::mint<SITY>(arg0, arg1, arg3), arg2);
    }

    public fun create(arg0: &mut 0x2::coin::TreasuryCap<SITY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SITY> {
        0x2::coin::mint<SITY>(arg0, arg1, arg2)
    }

    fun init(arg0: SITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SITY>(arg0, 3, b"SITY", b"SITY", b"Native token of @SuiCityP2E", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeig4236djyafwvxzkb3km7o3xa25lsfg55bxvyrwbxyemlzjnjjpsi.ipfs.w3s.link/sity%20logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SITY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

