module 0x72890862ce22878b689925bfb34fb6e410227af3ca46a010caf311259e1b200::fchad {
    struct FCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCHAD>(arg0, 6, b"FCHAD", b"FOMOCHAD", x"412070726f6a656374206275696c742061726f756e642074686520726973696e6720464f4d4f20696e207468652063727970746f206d61726b6574732020657370656369616c6c79206f6e207468652053554920426c6f636b636861696e212054686973206973207468652066697273742070726f6a6563742066726f6d206f7572207465616d2e204974732066756c6c79206c656769742c206c6f6e672d7465726d2c20616e6420706f77657265642062792074686520737069726974206f6620464f4d4f204d454d452e20427579206f757220746f6b656e2020616e6420737469636b207769746820757320666f72207468650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ffdffffff_da9ac9d825.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

