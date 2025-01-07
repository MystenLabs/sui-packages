module 0x2dc697e80c147cd0fa6d3ef8de249509c6fe92eacadeaf61d61cd2b5c7331696::suimas {
    struct SUIMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAS>(arg0, 6, b"SUIMAS", b"SUI CHRISTMAS", x"5468697320686f6c6964617920736561736f6e2c206c6574e28099732073686f772074686520776f726c6420746865206d61676963616c20706f776572206f66205375692e20466f7267657420626f72696e6720676966747320616e642073707265616420746865206a6f79206f66205375696d61732e20576174636820796f757220706f7274666f6c696f207368696e65206272696768746572207468616e2061204368726973746d6173207472656521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734181047239.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

