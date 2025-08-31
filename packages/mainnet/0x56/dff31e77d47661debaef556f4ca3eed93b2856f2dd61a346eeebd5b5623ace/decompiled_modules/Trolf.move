module 0x56dff31e77d47661debaef556f4ca3eed93b2856f2dd61a346eeebd5b5623ace::Trolf {
    struct TROLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLF>(arg0, 9, b"TROLF", b"Trolf", b"trump + golf = trolf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzrL_BBa8AEnS8G?format=png&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

