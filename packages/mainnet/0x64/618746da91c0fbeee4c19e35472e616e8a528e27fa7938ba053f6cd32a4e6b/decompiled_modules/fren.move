module 0x64618746da91c0fbeee4c19e35472e616e8a528e27fa7938ba053f6cd32a4e6b::fren {
    struct FREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREN>(arg0, 6, b"FREN", b"SUI FRENS", b"SuiFrens are beloved imaginative, inventive creatures traversing the internet, seeking fellow pioneers to build new connections and friendships", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RW_4_Xp_C25_400x400_be51a7b99e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

