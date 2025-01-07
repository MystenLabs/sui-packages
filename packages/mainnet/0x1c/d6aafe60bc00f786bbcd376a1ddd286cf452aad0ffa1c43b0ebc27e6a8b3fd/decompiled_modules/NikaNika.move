module 0x1cd6aafe60bc00f786bbcd376a1ddd286cf452aad0ffa1c43b0ebc27e6a8b3fd::NikaNika {
    struct NIKANIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKANIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKANIKA>(arg0, 9, b"$NIKA", b"NikaNika", b"The Nika God", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.upanh.org/2023/05/07/png-clipart-monkey-d-luffy-gomu-gomu-no-mi-one-piece-devil-fruit-paramecia-all-kinds-of-fruit-purple-violet36a837dba019935a.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NIKANIKA>(&mut v2, 10000000000 * 0x2::math::pow(10, 9), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIKANIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKANIKA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

