module 0xc932833493e64e8d21bb263e4c5cd96c4dce861848e7b6a3527825733f576acc::uspepe {
    struct USPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: USPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USPEPE>(arg0, 6, b"USPEPE", b"FIRST AMERICAN PEPE ON SUI", b"FIRST AMERICAN PEPE ON SUI : https://uspepesui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_5_cc58b74507.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

