module 0x32ce8cd4d1cca24852a714c21bddf0089d248cc781f27d09a3018af2ce235d0b::apt {
    struct APT has drop {
        dummy_field: bool,
    }

    fun init(arg0: APT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APT>(arg0, 9, b"APT", b"Aptos", b"asf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/5ff01845b9ed938d60797c66c36647c4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

