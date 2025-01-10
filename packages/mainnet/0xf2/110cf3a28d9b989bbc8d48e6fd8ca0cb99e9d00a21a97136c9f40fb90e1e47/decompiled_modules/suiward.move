module 0xf2110cf3a28d9b989bbc8d48e6fd8ca0cb99e9d00a21a97136c9f40fb90e1e47::suiward {
    struct SUIWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWARD>(arg0, 6, b"SUIWARD", b"SUIWARD TENTACLES", x"57484f204c4956455320494e20412050494e454150504c4520554e44455220544845205345413f0a0a5355495741524421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9108_364564673b.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

