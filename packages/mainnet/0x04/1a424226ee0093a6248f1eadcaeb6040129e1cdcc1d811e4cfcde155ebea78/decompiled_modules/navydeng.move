module 0x41a424226ee0093a6248f1eadcaeb6040129e1cdcc1d811e4cfcde155ebea78::navydeng {
    struct NAVYDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVYDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVYDENG>(arg0, 6, b"NAVYDENG", b"navydeng", b" We are stronger together! Keep your eyes on the horizon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdasd_de7d446fb6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVYDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAVYDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

