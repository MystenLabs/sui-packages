module 0x75fc6fa1787f7eaa84abbc0f9fa5cbdcf6e759b290f6b66536884dacf9b30262::prf {
    struct PRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRF>(arg0, 6, b"PRF", b"PerForm", b"Starii Ded Maksim", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_1b88a6cb62.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

