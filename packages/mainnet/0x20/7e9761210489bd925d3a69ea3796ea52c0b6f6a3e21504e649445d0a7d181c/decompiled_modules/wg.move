module 0x207e9761210489bd925d3a69ea3796ea52c0b6f6a3e21504e649445d0a7d181c::wg {
    struct WG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WG>(arg0, 9, b"WG", b"Warthong", x"57617274686f672069732061206d656d6520746f6b656e20756e6465722053554920426c6f636b636861696e2c207468697320746f6b656e2069732061696d696e67206174206177616b656e696e672074686520706f776572206f66204d722077617274686f6e672074686174207761732073746f6c656e206279204d72206c696f6e20617320746865206b696e67206f6620746865206a756e676c652e204c6574277320737570706f7274204d722077617274686f6e6720746f2072656761696e2069747320706f77657220616e6420686176652066756e6e7920f09f988a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15bad47f-72c2-4d59-be5b-b8506755e218.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WG>>(v1);
    }

    // decompiled from Move bytecode v6
}

