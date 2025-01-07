module 0x3548148e03e6153ae1981865b23cfa10ef6875d01e666cd80f281d2e820da04f::azileai {
    struct AZILEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZILEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZILEAI>(arg0, 6, b"AZILEAI", b"Azile AI", b"AZILE AI is a real girl. The first memoji brought to life using the ai16z framework.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1234235423_60afeb6698.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZILEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZILEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

