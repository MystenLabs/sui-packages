module 0xf70ee8103a45246df01e44819e2fa1af2bed803c1c8b78596feab3e087f0825f::t47 {
    struct T47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T47>(arg0, 9, b"T47", b"TOKEN47", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T47>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T47>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T47>>(v2);
    }

    // decompiled from Move bytecode v6
}

