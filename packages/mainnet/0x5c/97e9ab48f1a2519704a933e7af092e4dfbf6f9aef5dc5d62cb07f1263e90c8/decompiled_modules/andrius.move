module 0x5c97e9ab48f1a2519704a933e7af092e4dfbf6f9aef5dc5d62cb07f1263e90c8::andrius {
    struct ANDRIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDRIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDRIUS>(arg0, 6, b"ANDRIUS", b"Andrius Maximus", x"4265686f6c6420416e6472697573204d6178696d75732c2074686520756c74696d61746520676c61646961746f7220696e73706972656420627920416e647265772054617465e280997320756e627265616b61626c65206d696e6473657420616e642077617272696f72207370697269742120496e207468652063727970746f20436f6c6f737365756d2c2024414e4452495553207374616e6473206173207468652073796d626f6c206f6620726573696c69656e63652c20646f6d696e616e63652c20616e642074686520756e7969656c64696e672070757273756974206f6620766963746f727921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735997732084.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANDRIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDRIUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

