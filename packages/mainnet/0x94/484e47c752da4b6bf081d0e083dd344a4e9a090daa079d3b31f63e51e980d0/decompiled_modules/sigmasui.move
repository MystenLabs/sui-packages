module 0x94484e47c752da4b6bf081d0e083dd344a4e9a090daa079d3b31f63e51e980d0::sigmasui {
    struct SIGMASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGMASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGMASUI>(arg0, 9, b"SigmaSui", b"SuiSigma", b"A meme coin dedicated to thinking differently about the world around you, doing what is best for yourself and those around you, and having fun in the process while thinking critically.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8a1f2d4782a919b37dc52062a96bf2d3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIGMASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

