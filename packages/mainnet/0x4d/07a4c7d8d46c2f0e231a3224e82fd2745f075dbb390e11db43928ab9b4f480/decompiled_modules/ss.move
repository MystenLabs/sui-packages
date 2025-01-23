module 0x4d07a4c7d8d46c2f0e231a3224e82fd2745f075dbb390e11db43928ab9b4f480::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 6, b"SS", b"SuiStonks", x"54686520666972737420616e642061757468656e746963202453746f6e6b73206465706c6f796564206f6e2024535549206261636b6564206279204e6173646171204d656d652e2057696c6c2073656e642068616c662063726561746f7220746f6b656e20736861726520746f205361746f7368692057616c6c6574206966206d61726b6574206361702068697473202431303030302e200a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737631478293.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

