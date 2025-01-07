module 0x29199d01d14a0006d12195380a5a29d9b17540f06fa878a7b181fe3971839e79::blubi {
    struct BLUBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBI>(arg0, 6, b"BLUBI", b"Sui Blubi", b"$BLUBI. surf the ocean with blubi, and conquer the sui waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_64_843fa18088.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

