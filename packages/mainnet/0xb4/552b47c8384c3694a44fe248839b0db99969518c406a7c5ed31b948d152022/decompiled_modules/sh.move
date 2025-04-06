module 0xb4552b47c8384c3694a44fe248839b0db99969518c406a7c5ed31b948d152022::sh {
    struct SH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SH>(arg0, 9, b"SH", b"SuiSheep", b"SuiSheep is the black sheep of the crypto family, flocking together the quirkiest investors on the Sui network. It's all about following the herd but with a twist - every transaction triggers a random \"baa\" sound on your device (just kidding, but wouldn't that be fun?).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/957559008de34133b0ef369a036ce85dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

