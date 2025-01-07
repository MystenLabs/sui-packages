module 0xbf26b5ef11717d04264f56e053740ff1b678cefa614e9ded5ad5b6db6904e0b7::floppa {
    struct FLOPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOPPA>(arg0, 6, b"Floppa", b"Floppa on Sui", b"Inspired by a memecoin on Base, where the developer sold his entire supply for $35k, the community has started to take over and is now sending it to gorillions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_4994657455120166085_c_f09cc2e42e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

