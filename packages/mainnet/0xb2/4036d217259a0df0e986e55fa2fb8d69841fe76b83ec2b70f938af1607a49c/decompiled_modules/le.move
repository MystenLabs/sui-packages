module 0xb24036d217259a0df0e986e55fa2fb8d69841fe76b83ec2b70f938af1607a49c::le {
    struct LE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LE>(arg0, 6, b"Le", b"M", b"Tappe moi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_9d352f4b01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LE>>(v1);
    }

    // decompiled from Move bytecode v6
}

