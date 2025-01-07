module 0x8ad6b1ed32af34a563efeacb5ab4581735df42a5a96c66a2267d4aacb660c325::sail {
    struct SAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIL>(arg0, 6, b"Sail", b"Sailor Sui", b"Imagine a vibrant blue man standing proudly on a small boat. The sun reflects off the water, creating a serene atmosphere. The sail is bright and bold, displaying the letters \"SUI\" in a striking font. The background features a clear blue sky with a few fluffy clouds, and perhaps distant hills or a coastline. The scene captures a sense of adventure and tranquility. How does that sound?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image0_copy_ea9046a3f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

