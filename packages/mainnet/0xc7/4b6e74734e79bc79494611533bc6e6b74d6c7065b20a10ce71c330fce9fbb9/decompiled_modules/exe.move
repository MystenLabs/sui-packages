module 0xc74b6e74734e79bc79494611533bc6e6b74d6c7065b20a10ce71c330fce9fbb9::exe {
    struct EXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXE>(arg0, 6, b"EXE", b"SUI.exe", b"The most advanced AI, will guide you through  the escape of the  Matrix.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifqyuy3pzjsy6asmijxdt5itc24vxl4eilwyq4lo2bsqtcxxrdgr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EXE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

