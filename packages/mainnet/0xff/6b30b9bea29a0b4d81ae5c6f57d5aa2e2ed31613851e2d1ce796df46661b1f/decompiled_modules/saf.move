module 0xff6b30b9bea29a0b4d81ae5c6f57d5aa2e2ed31613851e2d1ce796df46661b1f::saf {
    struct SAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAF>(arg0, 6, b"SAF", b"Sui Animal Farm", b"Join us on TG: http://t.me/sui_animal_farm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avt_015e9e3beb.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

