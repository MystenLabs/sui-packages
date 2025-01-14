module 0xdb01c66b69eca98e7b7edbac4b642d0e7b476b10b0fe38455336b342c3872b93::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 9, b"AI", b"AI1000", b"AI1K", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bing.com/images/search?q=Ai+Background+Images+for+PPT&FORM=IRIBEP")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

