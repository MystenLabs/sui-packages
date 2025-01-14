module 0xbfe64d5190c4a0a738a58fe4fa5b11fcbe1e6d9f5277a8ff6c683c909c991dfe::drones {
    struct DRONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRONES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DRONES>(arg0, 6, b"DRONES", b"Drones AI by SuiAI", b"Drones science & mysterious drone sightings", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/N_Ih_H_Nn_U4_400x400_59f84d7179.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRONES>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRONES>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

