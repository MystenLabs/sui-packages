module 0x812b77054069dd3e06815c84600eace380eb4fb36fd1d9db4cb4f13051a57cea::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 6, b"iuS", b"IUS", b"Everything has turned upside down!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/indir_13de75e595.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

