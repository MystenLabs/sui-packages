module 0x3da768caa18462ba51418a7a98f304e343a0479ccce02c0ce829cb45445d3fc3::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"STONEFISH AI", b"No socials yet, let's send it first! Stonefish is considered the most venomous fish in the world and will take over Sui ocean! LFG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733622803832.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

