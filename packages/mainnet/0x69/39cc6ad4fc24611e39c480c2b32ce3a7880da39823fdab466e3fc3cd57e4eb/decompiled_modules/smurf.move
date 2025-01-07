module 0x6939cc6ad4fc24611e39c480c2b32ce3a7880da39823fdab466e3fc3cd57e4eb::smurf {
    struct SMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURF>(arg0, 6, b"SMURF", b"Suimurf", b"Small in size, big on memecoin dreams!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_161431_6f4187a664.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

