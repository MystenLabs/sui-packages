module 0xa534d4ce7ae9efecebfaa3039de509926bf15d02948eeca58a55f4f470b73567::sbrett {
    struct SBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBRETT>(arg0, 6, b"SBRETT", b"Sui Brett", b"Introducing $SBRETT, The Brett of Sui Network. Brett is one of the main characters in the webcomic ''Boys Club''", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x237de75172ae54040b2165101e04f8978a3f4b3480f6ab65faccb0c5e28ac6bd_sbrett_sbrett_915666519f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

