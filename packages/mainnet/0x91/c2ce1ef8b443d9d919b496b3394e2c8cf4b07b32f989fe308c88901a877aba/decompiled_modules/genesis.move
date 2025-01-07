module 0x91c2ce1ef8b443d9d919b496b3394e2c8cf4b07b32f989fe308c88901a877aba::genesis {
    struct GENESIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENESIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENESIS>(arg0, 9, b"GENESIS", b"Bitcoin Genesis", x"4f6e204a616e756172792033726420323030392c2074686520426974636f696e206e6574776f726b207761732063726561746564207768656e205361746f736869204e616b616d61746f206d696e65642074686520e2809c47656e65736973e2809d20626c6f636b2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXzeMiEqYRLX8FAXuZLRSni4B6pfnBz7MUwtCbFzDZmve")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GENESIS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENESIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENESIS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

