module 0x92afc26c07a9df48e2a14b73dd96f12b42e942ea768d8929e4f4f4f3815c8e1::octo {
    struct OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTO>(arg0, 6, b"OCTO", b"octopus", b"I come from SUI Ocean. I am the mascot of the ocean and also the mascot of SUI. I am an octopus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726045688270_40888504df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

