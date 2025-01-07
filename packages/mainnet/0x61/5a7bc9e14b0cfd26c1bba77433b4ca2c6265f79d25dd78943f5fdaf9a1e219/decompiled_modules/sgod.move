module 0x615a7bc9e14b0cfd26c1bba77433b4ca2c6265f79d25dd78943f5fdaf9a1e219::sgod {
    struct SGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOD>(arg0, 9, b"SGOD", b"SUPER GOD", x"4865617264206f6620444f47533f204d6565742053474f44e2809474686520666c69707065642c2065766f6c7665642076657273696f6e206f6620444f47532c20617363656e64696e6720746f20676f642d74696572207374617475732077686572652069726f6e79206d6565747320696e6e6f766174696f6e2e20496620444f47532069732061206c6567656e642c2053474f44206973207468652066757475726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c07e635-5166-4b5b-9452-92aa63085b80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

