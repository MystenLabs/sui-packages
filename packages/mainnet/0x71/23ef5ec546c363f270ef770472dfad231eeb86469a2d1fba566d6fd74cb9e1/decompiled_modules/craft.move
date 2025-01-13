module 0x7123ef5ec546c363f270ef770472dfad231eeb86469a2d1fba566d6fd74cb9e1::craft {
    struct CRAFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAFT>(arg0, 9, b"CRAFT", b"CodeCraft AI", x"5472616e73666f726d20696465617320696e746f20636f64652077697468206f7572206d756c7469204149206167656e7420737761726d210d0a496e70757420796f757220646573697265642070726f6d70742c20736974206261636b20616e64207761746368206f7572206167656e74732064656c697665722074686520636f646520746f2061206e657720476974687562207265706f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWVSDeybeksyH65yuVmM6rsXBLriSG68JQMuxtYjPTkAS")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CRAFT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRAFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAFT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

