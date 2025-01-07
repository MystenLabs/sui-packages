module 0x3999eba0b26f6afbe4207d4ddf6a352f921a8eac268398ab70be36218755227e::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"BUBL", b"Bubl", x"427562626c65732061726520657665727977686572652077617465722069732c20616e6420537569206973206e6f20657863657074696f6e2e20546865792070756d702c20666c6f61742c20616e6420626f696c20e2809420746865792772652066756e2e205375692069732077617465722c207761746572206e65656473204255424c732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731342356871.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

