module 0x3d309c6c99a60485b37c73dfec433c5734d851d00da9baee590580151d662cb::gmn {
    struct GMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMN>(arg0, 6, b"GMN", b"GMNET", b"$GMN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dys0_Mti_K_400x400_8cde06eb31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

