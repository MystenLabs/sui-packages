module 0x77c8299110938050a97611cbf7e000ce793904ce08df6016a443214a030d32bd::tsu {
    struct TSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSU>(arg0, 9, b"TSU", b"tSui", b"TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/473b89b559b4f4ec5e9e750bc6381d5eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

