module 0x9d25e0663fd648e46c7e57d1f37acd48e80fa6eda538b7ca3ac04bb0ab746f72::suijak {
    struct SUIJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJAK>(arg0, 4, b"Suijak", b"SJAK", b"t.me/SuijakCoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/MNrs1ws/suijak.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIJAK>>(v1);
        0x2::coin::mint_and_transfer<SUIJAK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIJAK>>(v2);
    }

    // decompiled from Move bytecode v6
}

