module 0x18c90319bf3987d5cbc0b909b826cb84106fdfff5794c810966fe01500dfa16e::clay {
    struct CLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nClayApe";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = x"644d6f6c6465642062792068616e64206f7574206f6620706c617967726f756e6420706c6173746963696e652c20436c617941706520697320746f6f20686561767920746f20666c79206f6e2061207265616c20726f636b65742e20496e73746561642c206865206a757374206368696c6c73206f6e20612063617264626f6172642069736c616e642c206d696e74696e6720686973206f776e20686f6d656d61646520746f6b656e7320616e642073746172696e672061742061207061706965722d6dc3a26368c3a9206d6f6f6e2e203130302520756e626f7468657265642c203025206c69717569642e";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<CLAY>(arg0, 6, b"CLAY", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/aAPSeivFKztUwEth")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

