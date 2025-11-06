module 0x417f342d5add7aec30e50b78067a4e8a23e1c5b779468fa01282e4e147ca5fb8::broke {
    struct BROKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKE>(arg0, 9, b"BROKE", b"Broke Chain", b"Just a cat with a Broke Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BROKE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKE>>(v2, @0x46afa9d130041789198e841e4b3d57ee8dc8bcc9f869b6494443dc8cfb595c62);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

