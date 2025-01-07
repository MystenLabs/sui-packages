module 0xb4fabd8ccdc273f0bd52c30175c13903c642d4fe140459209e815f7f6b8e440c::drink {
    struct DRINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRINK>(arg0, 9, b"DRINK", b"DRINKIES", b"NO WAY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1a68e054301fce83b3c34f5434c6c663blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

