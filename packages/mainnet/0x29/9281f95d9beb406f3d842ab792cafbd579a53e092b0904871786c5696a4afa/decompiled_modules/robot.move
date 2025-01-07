module 0x299281f95d9beb406f3d842ab792cafbd579a53e092b0904871786c5696a4afa::robot {
    struct ROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOT>(arg0, 9, b"ROBOT", b"ROBOT IS ALIVE", b"Something majestic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/darmowe-zdjecie/dzialajacy-robot-dostawczy-3d_23-2151150169.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROBOT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

