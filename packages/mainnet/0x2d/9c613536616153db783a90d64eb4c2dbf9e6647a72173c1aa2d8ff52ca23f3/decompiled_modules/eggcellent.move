module 0x2d9c613536616153db783a90d64eb4c2dbf9e6647a72173c1aa2d8ff52ca23f3::eggcellent {
    struct EGGCELLENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGCELLENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGCELLENT>(arg0, 6, b"Eggcellent", b"Eggcellent ", x"596f75e2809972652045676763656c6c656e740a45676763656c6c656e6379200a4c65747320616c6c2062652045676763656c6c656e740a49742077696c6c20626520746865206e65787420626967207468696e670a42652065676779", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1744061131880.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGGCELLENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGCELLENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

