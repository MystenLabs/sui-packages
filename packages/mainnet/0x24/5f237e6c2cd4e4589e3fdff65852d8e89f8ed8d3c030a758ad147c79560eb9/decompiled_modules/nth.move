module 0x245f237e6c2cd4e4589e3fdff65852d8e89f8ed8d3c030a758ad147c79560eb9::nth {
    struct NTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTH>(arg0, 9, b"NTH", b"Nothing", b"X Contributors", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a42e6144abb81aecb7785567df687344blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

