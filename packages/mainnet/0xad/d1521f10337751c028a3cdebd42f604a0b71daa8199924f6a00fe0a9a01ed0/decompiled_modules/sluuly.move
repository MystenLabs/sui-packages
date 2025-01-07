module 0xadd1521f10337751c028a3cdebd42f604a0b71daa8199924f6a00fe0a9a01ed0::sluuly {
    struct SLUULY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUULY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUULY>(arg0, 6, b"SLUULY", b"Stoned Sluuly", b"Meet Stoned Sluuly , the chillest snail on the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019186_97e1103ce8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUULY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUULY>>(v1);
    }

    // decompiled from Move bytecode v6
}

