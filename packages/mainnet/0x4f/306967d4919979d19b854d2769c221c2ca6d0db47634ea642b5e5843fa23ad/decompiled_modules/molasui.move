module 0x4f306967d4919979d19b854d2769c221c2ca6d0db47634ea642b5e5843fa23ad::molasui {
    struct MOLASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLASUI>(arg0, 6, b"MOLASUI", b"MOLA", x"4d0a6f0a760a650a200a530a6c0a6f0a770a2e0a200a430a680a690a6c0a6c0a200a480a610a720a640a2e0a200a4d0a6f0a6f0a6e0a200a460a610a730a740a2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NA_vtelen_e1546ff2b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

