module 0x5e05aa1e26d92f24c3379abeb898475991120e7c30faeeed8ce4aed8d4163ad5::jobfree {
    struct JOBFREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOBFREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOBFREE>(arg0, 6, b"JOBFREE", b"JobFreeToken", x"2d20224a6f6246726565546f6b656e202043656c6562726174696e672066726565646f6d2066726f6d20776f726b21220a2d20224e6f20776f726b2c206a7573742066756e2077697468204a6f6246726565546f6b656e21220a2d202254696d6520746f20646973636f6e6e6563742066726f6d20776f726b2e20436f6e6e6563742077697468204a6f6246726565546f6b656e21220a2d2022576f726b2063616e20776169742e20497427732074696d6520666f72204a6f6246726565546f6b656e2122", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_3d93be1035.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOBFREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOBFREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

