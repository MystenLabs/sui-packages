module 0xe1c3b7181c94c757cc008672206187d4eda9c56080e4b4c74c9b27b22452329::dug {
    struct DUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUG>(arg0, 6, b"DUG", b"DUG THE DOG", b"Dug the dog| $DUG  The master of all dogs, the latest ruler of the meme empire. One bark send chart flying", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032663_845cb0209e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

