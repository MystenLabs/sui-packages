module 0x9287e05dc27d6f9e4e40192fe87ec990c82dc1fb7bf90b83fada5fed3cb7f4f6::msftconsp98 {
    struct MSFTCONSP98 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSFTCONSP98, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSFTCONSP98>(arg0, 6, b"MSFTCONSP98", b"MicroSuift Conspirio 98", b"MicroSuift Conspirio 98 is the ultimate throwback to tech nostalgia, mixing the glitches of 90s software with modern-day conspiracy theories! In this memecoin, every bug is a \"feature\" and every system crash is part of the grand plan. Its a wild ride back to 1998, where floppy disks ruled and blue screens were the norm, but with a sneaky twistwhos really pulling the strings behind the code?  #Conspirio98 #NotABugItsAFeature #BlueScreenOfCrypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_13_T212728_432_a75e84bd68.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSFTCONSP98>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSFTCONSP98>>(v1);
    }

    // decompiled from Move bytecode v6
}

