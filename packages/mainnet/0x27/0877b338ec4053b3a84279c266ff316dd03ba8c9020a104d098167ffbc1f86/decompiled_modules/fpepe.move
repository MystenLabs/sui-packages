module 0x270877b338ec4053b3a84279c266ff316dd03ba8c9020a104d098167ffbc1f86::fpepe {
    struct FPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPEPE>(arg0, 6, b"FPEPE", b"Father Pepe", b"fatherpepeblessing.xyz. Let us pray together for peace and justice in the world and help those in need, always ready to share the love of God.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/group_4_YX_4y20rlo9i_D_Mrvp_71c5730071.avif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

