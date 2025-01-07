module 0xb2adcfe4b55c1990350bcf9daf9088bf8cb35a9eb9e4e7cca67093e0a2ee405c::loofi {
    struct LOOFI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOOFI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOOFI>>(0x2::coin::mint<LOOFI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: LOOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOFI>(arg0, 9, b"LOOFI", b"LOOFI", b"The amazing sui Yeti fan club here to embrace the community giving the chance to be early.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1860099958117896192/RIZWNf_O_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOOFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOFI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

