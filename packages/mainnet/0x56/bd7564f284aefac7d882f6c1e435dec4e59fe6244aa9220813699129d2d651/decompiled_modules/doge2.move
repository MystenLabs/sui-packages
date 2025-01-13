module 0x56bd7564f284aefac7d882f6c1e435dec4e59fe6244aa9220813699129d2d651::doge2 {
    struct DOGE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE2>(arg0, 6, b"DOGE2", b"Dogecoin", b"Doge on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/ec500880-2ea7-4398-b422-56feda0e0bd6.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

