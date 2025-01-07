module 0xc67689a0e003f6b3ed0434498672e2f63ab87db4b284dcdf1ba7169b02c9c56b::cb {
    struct CB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CB>(arg0, 6, b"CB", b"Cheeseball", b"CheesebellTheWizard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_18_43_38_0484d16588.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CB>>(v1);
    }

    // decompiled from Move bytecode v6
}

