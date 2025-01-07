module 0x3134e02396f3ed9a0ac3a72848285b856fa711bfe41bcd37767954528beed715::atlan {
    struct ATLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATLAN>(arg0, 6, b"ATLAN", b"ATLANSUI", b"Pledge your NFTs, Earn $SUI Instantly with AtlanSui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_50680bbdee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

