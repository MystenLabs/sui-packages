module 0xa2c5e4157ca401d44ac0547515d9a98f0dcbad1a876d2ecc77318e590ea0bfb3::torque {
    struct TORQUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORQUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORQUE>(arg0, 9, b"TORQUE", b"APPLY TORQUE", b"TORQUE is native coin of applytorque.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/Sl6OY9Zm85V8dNx3a1q8ZZ13DprVR3eQ-CBZHJ-fWBA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TORQUE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORQUE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TORQUE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

