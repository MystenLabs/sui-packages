module 0xf443648e909ed2da5a8ae6ff9434d4208a95b9de3122b26724b4aadbecda37::sply {
    struct SPLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLY>(arg0, 6, b"SPLY", b"Splashy", b"Splashy represents all things fun in the Sui ecosystem. Let us all splash together on the water chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4790_3f393f9bfc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

