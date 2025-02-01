module 0xc312d956dbd1b319c04ffd7bc683778fcfdb44519a92be10a26bfe2e3de78160::aasacsac {
    struct AASACSAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AASACSAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AASACSAC>(arg0, 6, b"Aasacsac", b"xasxcsasc", b"accaa qw  a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_1e662f922f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AASACSAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AASACSAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

