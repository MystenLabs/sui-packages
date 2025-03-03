module 0xdbe6cb35e1db4f341572ce5342730cfca4702a1775f86a64be37e47739625f00::est {
    struct EST has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST>(arg0, 9, b"EST", b"EstergoN", b"bla bla bla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f79c38ccfff2ceaa5461edca9bd216dablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

