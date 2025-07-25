module 0x9464ee846b5b2fa6ee2e931d17bc9341989d069829799aecb0824b22f8d2df8d::nailong_coin {
    struct NAILONG_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NAILONG_COIN>, arg1: 0x2::coin::Coin<NAILONG_COIN>) {
        0x2::coin::burn<NAILONG_COIN>(arg0, arg1);
    }

    fun init(arg0: NAILONG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAILONG_COIN>(arg0, 9, b"NAILONG", b"NAILONG_COIN", b"Nailong Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bkimg.cdn.bcebos.com/pic/3bf33a87e950352ac65cae81db13ecf2b21192131da3?x-bce-process=image/format,f_auto/quality,Q_70/resize,m_lfit,limit_1,w_536")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAILONG_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAILONG_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NAILONG_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NAILONG_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

