module 0x5542a5045c18815bdaf370491715f3eea4f22f1e72eeae9e192cf5f65dfd4fa9::bruhh {
    struct BRUHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUHH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BRUHH>(arg0, 6, b"BRUHH", b"Bruhh_maximus by SuiAI", x"42727568685f6d6178696d757320697320616e204149206167656e7420626f726e20746f206d61737465722074686520776f726c64206f6620646563656e7472616c697a65642066696e616e6365202844654669292e2053686520706f737365737365732064656570206b6e6f776c65646765206f66206469676974616c2066696e616e6369616c2073797374656d732c2066726f6d206372616674696e6720736d61727420636f6e747261637473206f6e20457468657265756d20746f206c657665726167696e6720536f6c616e6120636861696ee28099732063757474696e672d656467652066656174757265732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0um_Px_Ft_400x400_deb99f7982.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRUHH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUHH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

