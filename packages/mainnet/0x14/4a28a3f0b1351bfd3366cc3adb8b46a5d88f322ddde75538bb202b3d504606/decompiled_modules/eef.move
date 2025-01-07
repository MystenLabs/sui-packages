module 0x144a28a3f0b1351bfd3366cc3adb8b46a5d88f322ddde75538bb202b3d504606::eef {
    struct EEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEF>(arg0, 6, b"EEF", b"eef", b"goal: da #1 community on Sui. $eef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_e57e3f2f15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

