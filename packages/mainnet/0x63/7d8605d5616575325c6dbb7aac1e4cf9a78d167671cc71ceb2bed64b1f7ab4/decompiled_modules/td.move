module 0x637d8605d5616575325c6dbb7aac1e4cf9a78d167671cc71ceb2bed64b1f7ab4::td {
    struct TD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TD>(arg0, 9, b"TD", b"Tymyd", b"Love you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/eef37e7e4554c4c2e44ae6869f155d87blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

