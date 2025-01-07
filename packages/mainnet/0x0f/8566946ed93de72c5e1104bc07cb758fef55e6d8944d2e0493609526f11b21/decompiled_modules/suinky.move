module 0xf8566946ed93de72c5e1104bc07cb758fef55e6d8944d2e0493609526f11b21::suinky {
    struct SUINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINKY>(arg0, 6, b"Suinky", b"Suinky Winky", b"Suinky Winky inspired by the teletubbies. A Token Created for my Kids. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022178_fa71e86b1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

