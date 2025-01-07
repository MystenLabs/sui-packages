module 0x8fa93431db82aa6cba81dfb8e899de227fdcefd1d9b741989f84f027b31edfa7::drones {
    struct DRONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRONES>(arg0, 6, b"DRONES", b"Jersey Drones", b"The Jersey Drone Token, spying on the skies, mooning from the shore", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_str_HWT_400x400_68db9d6541.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRONES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRONES>>(v1);
    }

    // decompiled from Move bytecode v6
}

