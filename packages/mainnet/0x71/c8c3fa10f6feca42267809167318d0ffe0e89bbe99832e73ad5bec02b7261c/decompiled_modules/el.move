module 0x71c8c3fa10f6feca42267809167318d0ffe0e89bbe99832e73ad5bec02b7261c::el {
    struct EL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EL>(arg0, 9, b"EL", b"electric", b"We live in a full electricity dependance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/88b97d216814ce389bd063216759e3bfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

