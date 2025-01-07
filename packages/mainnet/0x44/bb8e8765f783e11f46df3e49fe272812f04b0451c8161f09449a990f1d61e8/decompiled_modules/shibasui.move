module 0x44bb8e8765f783e11f46df3e49fe272812f04b0451c8161f09449a990f1d61e8::shibasui {
    struct SHIBASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBASUI>(arg0, 9, b"SHIBASUI", b"Shiba on Sui", b"Off token shiba on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIBASUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBASUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

