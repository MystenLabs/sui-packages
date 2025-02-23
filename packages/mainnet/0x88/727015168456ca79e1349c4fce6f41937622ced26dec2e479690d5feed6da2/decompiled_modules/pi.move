module 0x88727015168456ca79e1349c4fce6f41937622ced26dec2e479690d5feed6da2::pi {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 6, b"Pi", b"Pi Network", b"Pi Network allows global free transactions, users mine Pi coins on their phones without consuming much energy. More than 50 million users and the ability to increase the price x10 x100 times in the near future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/d4f91f6b-a723-4f2a-9a24-0c6e1f28d4d9.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

